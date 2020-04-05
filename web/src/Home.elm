module Home exposing (..)

import Html exposing (Html, Attribute, div, text, h1, input, label)
import Html.Attributes exposing (class, value, type_, readonly, style)
import Html.Attributes.Extra exposing (valueAsInt)
import Html.Events exposing (onInput)
import LineChart
import LineChart.Dots as Dots
import LineChart as LineChart
import LineChart.Junk as Junk
import LineChart.Container as Container
import LineChart.Interpolation as Interpolation
import LineChart.Axis.Intersection as Intersection
import LineChart.Legends as Legends
import LineChart.Line as Line
import LineChart.Events as Events
import LineChart.Grid as Grid
import LineChart.Area as Area
import Color
import Time
import DateFormat
import Lib
import Lib.Axis


-- STATE

type alias State = {
    extrapolationDatum: Datum,
    extrapolationDays: Int,
    hinted: List Datum
  }

initialState : State
initialState = {
    extrapolationDatum = Lib.fromJust <| Lib.atIndex germany 16,
    extrapolationDays = 22,
    hinted = []
  }

initialCmd : Cmd Message
initialCmd = Cmd.none


-- UPDATE

type Message =
  SetExtrapolationDate (List Datum) |
  SetExtrapolationDays String |
  Hint (List Datum)

update : Message -> State -> (State, Cmd Message)
update message state = case message of
  SetExtrapolationDate data ->
    case data of
      datum :: _ ->
        case Lib.atIndex germany <| Lib.daysDifference startDate datum.date of
          Just datum1 -> ({state | extrapolationDatum = datum1}, Cmd.none)
          Nothing -> (state, Cmd.none)
      _ ->
        (state, Cmd.none)

  SetExtrapolationDays string ->
    case String.toInt string of
      Just extrapolationDays -> ({state | extrapolationDays = extrapolationDays}, Cmd.none)
      Nothing -> (state, Cmd.none)

  Hint data ->
    ({state | hinted = data}, Cmd.none)


-- VIEW

view : State -> List (Html Message)
view state = [
    div [class "row mt-4 mb-2"] [
      div [class "col"] [
        h1 [] [text "Deutschland"],
        text "click the chart to change extrapolation date"
      ]
    ],
    div [class "row mb-2"] [
      div [class "col"] [
        chart state
      ]
    ],
    div [class "row mb-2"] [
      div [class "col"] (form state)
    ]
  ]

form : State -> List (Html Message)
form state = [
    div [class "form-group row"] [
      label [class "col-sm-4 col-md-3 col-lg-2 col-form-label"] [text "Extrapolation Date"],
      div [class "col-sm-3 col-md-2 col-xl-1"] [
        input [class "text-right", type_ "text", readonly True, class "form-control-plaintext", value (DateFormat.format "d.M.yyyy" Time.utc state.extrapolationDatum.date)] []
      ]
    ],
    div [class "form-group row"] [
      label [class "col-sm-4 col-md-3 col-lg-2 col-form-label"] [text "Extrapolation Days"],
      div [class "col-sm-3 col-md-2 col-xl-1"] [
        input [class "text-right", type_ "number", class "form-control", valueAsInt state.extrapolationDays, onInput SetExtrapolationDays] []
      ]
    ]
  ]

chart : State -> Html Message
chart state = LineChart.viewCustom (chartConfig state) [
    LineChart.line Color.blue Dots.circle "Germany fitted" (germanyFitted state.extrapolationDatum state.extrapolationDays),
    LineChart.line Color.red Dots.diamond "Germany" germany
  ]

chartConfig : State -> LineChart.Config Datum Message
chartConfig state = {
    x = Lib.Axis.time Time.utc 1600 "Date" .date,
    y = Lib.Axis.int 700 "Infections" .value,
    container = containerConfig,
    interpolation = Interpolation.default,
    intersection = Intersection.default,
    legends = Legends.default,
    events = events,
    junk = Junk.hoverMany state.hinted formatX formatY,
    grid = Grid.default,
    area = Area.default,
    line = Line.default,
    dots = Dots.default
  }

containerConfig : Container.Config msg
containerConfig = Container.custom {
    attributesHtml = [style "font-family" "monospace"],
    attributesSvg = [],
    size = Container.relative,
    margin = Container.Margin 60 200 60 100,
    id = "chart-1"
  }

events : Events.Config Datum Message
events = Events.custom [
    Events.onMouseMove Hint Events.getNearestX,
    Events.onMouseLeave <| Hint [],
    Events.onClick SetExtrapolationDate Events.getNearestX
  ]

formatX : Datum -> String
formatX datum =
  DateFormat.format "d.M.yyyy" Time.utc datum.date

formatY : Datum -> String
formatY datum =
  Lib.formatInt datum.value ++ " infections"



-- DATA

type alias Datum = {
    date : Time.Posix,
    value : Int
  }

germany : List Datum
germany = List.indexedMap (\i v -> {date = dateForIndex i, value = v}) germany1

germany1 : List Int
germany1 = [
    215,
    290,
    437,
    620,
    796,
    930,
    1022,
    1363,
    1942,
    2676,
    3647,
    5051,
    6334,
    7272,
    9278,
    12291,
    15788,
    19747,
    23757,
    27001,
    29286,
    32922,
    37679,
    43238,
    49018,
    55032,
    59755,
    62820,
    66898,
    72665,
    78406,
    83727,
    85778
  ]

germanyFitted : Datum -> Int -> List Datum
germanyFitted extrapolationDatum extrapolationDays =
  let
    firstDatum = Lib.fromJust <| List.head germany
    dateA = firstDatum.date
    valueA = toFloat firstDatum.value
    dateB = extrapolationDatum.date
    valueB = toFloat extrapolationDatum.value
    days = Lib.daysDifference dateA dateB

    f = (valueB / valueA) ^ (1.0 / toFloat days)

    value i = valueA * f ^ (toFloat i)

    indexes = List.range 0 extrapolationDays
  in
    List.map (\i -> {date = dateForIndex i, value = round <| value i}) indexes

dateForIndex : Int -> Time.Posix
dateForIndex i = Lib.plusDays startDate i

startDate : Time.Posix
startDate = Time.millisToPosix 1583107200000 -- 2.3.2020 0:00 UTC
