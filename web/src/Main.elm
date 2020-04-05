module Main exposing (..)

import Browser exposing (Document)
import Browser.Navigation as Navigation
import Html exposing (Html, Attribute, ul, li, button, div, text, span, nav, a)
import Html.Attributes exposing (id, class, type_, attribute, href)
import Url exposing (Url)
import Url.Parser as Parser exposing (Parser, (</>), oneOf, top, s, parse)
import Home
import About


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
  RouteHome Home.State |
  RouteAbout

isRouteHome : Route -> Bool
isRouteHome route = case route of
  RouteHome _ -> True
  _ -> False

isRouteAbout : Route -> Bool
isRouteAbout route = case route of
  RouteAbout -> True
  _ -> False


-- UPDATE

type Message =
  UrlChange Url |
  UrlRequest Browser.UrlRequest |
  HomeMessage Home.Message

routeParser : Parser ((Route, Cmd Message) -> a) a
routeParser =
  oneOf [
    Parser.map (RouteHome Home.initialState, Cmd.map HomeMessage Home.initialCmd) top,
    Parser.map (RouteAbout, Cmd.none) (s "about")
  ]

init : () -> Url -> Navigation.Key -> (State, Cmd Message)
init () url key = case parse routeParser url of
  Just (route, cmd) -> ({route = route, key = key}, cmd)
  Nothing -> ({route = RouteHome Home.initialState, key = key}, Cmd.map HomeMessage Home.initialCmd)

update : Message -> State -> (State, Cmd Message)
update message state =
  case (message, state.route) of
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

    (HomeMessage homeMessage, RouteHome homeState) ->
      let (homeState1, command) = Home.update homeMessage homeState in
      ({state | route = RouteHome homeState1}, Cmd.map HomeMessage command)

    _ -> (state, Cmd.none)


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
      RouteHome _ -> "Home"
      RouteAbout -> "About"
  in
    "Covid-19 Stats – " ++ suffix

body : State -> List (Html Message)
body state = [
    navbar state,
    case state.route of
      RouteHome homeState -> Html.map HomeMessage (Home.view homeState)
      RouteAbout -> About.view
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
        routeButton "/" isRouteHome "Home" model,
        routeButton "/about" isRouteAbout "About" model
      ]
    ]
  ]

routeButton : String -> (Route -> Bool) -> String -> State -> Html Message
routeButton path isActiveRoute name model =
  li ([class "nav-item"] ++ if (isActiveRoute model.route) then [class "active"] else [])  [
    a [class "nav-link", href path] [text name]
  ]
