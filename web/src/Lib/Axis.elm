module Lib.Axis exposing (int, time)

import LineChart.Axis as Axis
import LineChart.Axis.Title as Title
import LineChart.Axis.Range as Range
import LineChart.Axis.Line as AxisLine
import LineChart.Axis.Ticks as Ticks
import LineChart.Colors as Colors
import LineChart.Axis.Tick as Tick
import LineChart.Axis.Values as Values
import LineChart.Coordinate exposing (Range)
import Lib
import Svg exposing (Svg, Attribute)
import Svg.Attributes as Attributes
import Time


int : Int -> String -> (data -> Int) -> Axis.Config data msg
int pixels_ title_ variable_ = Axis.custom {
    title = Title.atDataMax 0 0 title_,
    variable = Just << (variable_ >> toFloat),
    pixels = pixels_,
    range = Range.padded 20 20,
    axisLine = AxisLine.rangeFrame Colors.gray,
    ticks = intTicks pixels_
  }

intTicks : Int -> Ticks.Config msg
intTicks pixels_ = Ticks.custom <| \data range_ ->
  let
    smallest = smallestRange data range_
    rangeLong = range_.max - range_.min
    rangeSmall = smallest.max - smallest.min
    diff = 1 - (rangeLong - rangeSmall) / rangeLong
    amount = round <| diff * toFloat pixels_ / 90
  in
    List.map tickInt <| Values.int (Values.around amount) smallest


time : Time.Zone -> Int -> String -> (data -> Time.Posix) -> Axis.Config data msg
time zone pixels_ title_ variable_ = Axis.time zone pixels_ title_ (variable_ >> Time.posixToMillis >> toFloat)

tickInt : Int -> Tick.Config msg
tickInt n = Tick.custom {
    position = toFloat n,
    color = Colors.gray,
    width = 1,
    length = 5,
    grid = True,
    direction = Tick.negative,
    label = Just <| label "inherit" (Lib.formatInt n)
  }

label : String -> String -> Svg.Svg msg
label color string = Svg.text_ [Attributes.fill color, Attributes.style "pointer-events: none;"] [
    Svg.tspan [] [Svg.text string]
  ]


smallestRange : Range -> Range -> Range
smallestRange data range_ = {
    min = Basics.max data.min range_.min,
    max = Basics.min data.max range_.max
  }
