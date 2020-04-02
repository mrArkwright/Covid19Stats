module Main exposing (..)

import Browser exposing (Document)
import Browser.Navigation as Navigation
import Html exposing (Html, Attribute, ul, li, button, div, text, span, nav, a, h1, p)
import Html.Attributes exposing (id, class, type_, attribute, href)
import Url exposing (Url)
import Url.Parser exposing (Parser, (</>), map, oneOf, s, parse)


main =
  Browser.application {
    init = init,
    update = update,
    view = view,
    subscriptions = always Sub.none,
    onUrlRequest = UrlRequest,
    onUrlChange = UrlChange
  }


-- STATE

type alias State = {
    route: Route,
    key: Navigation.Key
  }

type Route =
  RouteHome

isRouteHome : Route -> Bool
isRouteHome route = case route of
  RouteHome -> True


-- UPDATE

type Message =
  UrlChange Url |
  UrlRequest Browser.UrlRequest

routeParser : Parser ((Route, Cmd Message) -> a) a
routeParser =
  oneOf [
    map (RouteHome, Cmd.none) (s "")
  ]

init : () -> Url -> Navigation.Key -> (State, Cmd Message)
init () url key = case parse routeParser url of
  Just (route, cmd) -> ({route = route, key = key}, cmd)
  Nothing -> ({route = RouteHome, key = key}, Cmd.none)

update : Message -> State -> (State, Cmd Message)
update msg state =
  case (msg, state.route) of
    (UrlRequest urlRequest, _) ->
      case urlRequest of
        Browser.Internal url ->
          (state, Navigation.pushUrl state.key (Url.toString url))

        Browser.External href ->
          (state, Navigation.load href)

    (UrlChange url, _) ->
      let _ = Debug.log "url" url in
      let _ = Debug.log "route" (parse routeParser url) in
      case parse routeParser url of
        Just (route, cmd) ->
          ({state | route = route}, cmd)
        Nothing -> (state, Cmd.none)

    --_ -> (state, Cmd.none)


-- VIEW

view : State -> Document Message
view state = {
    title = title state,
    body = body state
  }

title : State -> String
title state =
  let
    suffix = case state.route of
      RouteHome -> "Home"
  in
    "Covid-19 Stats – " ++ suffix

body : State -> List (Html Message)
body model =
  [
    Html.main_ [attribute "role" "main"] [
      navbar model,
      div [class "jumbotron"] [
        h1 [class "display-4"] [text "No content yet 🤷‍♂️"],
        p [class "lead"] [text "coming soonish…"]
      ]
    ]
  ]

navbar : State -> Html Message
navbar model =
  nav [class "navbar navbar-expand-sm navbar-dark bg-dark"] [
    span [class "navbar-brand mb-0 h1"] [text "Covid-19 Stats"],
    button [class "navbar-toggler", type_ "button", attribute "data-toggle" "collapse", attribute "data-target" "#navbarSupportedContent"] [
      span [class "navbar-toggler-icon"] []
    ],
    div [class "collapse navbar-collapse", id "navbarSupportedContent"] [
      ul [class "navbar-nav mr-auto"] [
        routeButton "/" isRouteHome "Home" model
      ]
    ]
  ]

routeButton : String -> (Route -> Bool) -> String -> State -> Html Message
routeButton path isActiveRoute name model =
  li ([class "nav-item"] ++ if (isActiveRoute model.route) then [class "active"] else [])  [
    a [class "nav-link", href path] [text name]
  ]
