module Lib exposing (..)

import FormatNumber
import FormatNumber.Locales as FormatNumberLocales
import Time


formatInt i =
  let
    baseLocale = FormatNumberLocales.usLocale
    locale = { baseLocale | decimals = FormatNumberLocales.Exact 0 }
  in
    FormatNumber.format locale <| toFloat i

plusDays : Time.Posix -> Int -> Time.Posix
plusDays date days = Time.millisToPosix <| Time.posixToMillis date + days * 24 * 60 * 60 * 1000

daysDifference : Time.Posix -> Time.Posix -> Int
daysDifference dateA dateB = round <| (toFloat (Time.posixToMillis dateB - Time.posixToMillis dateA)) / (24.0 * 60.0 * 60.0 * 1000.0)

atIndex : List a -> Int -> Maybe a
atIndex xs i = List.head <| List.drop i xs

fromJust : Maybe a -> a
fromJust x = case x of
    Just y -> y
    Nothing -> Debug.todo "fromJust Nothing"
