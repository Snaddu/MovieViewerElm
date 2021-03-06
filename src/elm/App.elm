module App exposing (..)

import Html exposing (Html, text, div, img)
import Html.Attributes exposing (class)

import Messages exposing(Msg(OnLocationChange))
import Navigation exposing (Location)
import Routing exposing (..)
import Update exposing (update)

import Sidebar.View exposing (sidebar)
import Content.View exposing (content)
import Movies.MovieDetail exposing (moviedetail)
import Components.Loader exposing(loader)

import Models exposing(initialModel, Model)

import Commands exposing (fetchGenres)

import Animation exposing(subscription)
import Messages exposing(..)

---- MODEL ----

init : Location -> ( Model, Cmd Msg )
init location =
  let
    currentRoute =
      Routing.parseLocation location
  in
  ( initialModel currentRoute, fetchGenres )

---- VIEW ----


view : Model -> Html Msg
view model =
    div [class "view"]
        [ sidebar model.genre
        , content model
        , moviedetail model
        , loader model.loaderStyle
        ]

subscriptions : Model -> Sub Msg
subscriptions model =
    Animation.subscription Animate [ model.loaderStyle ]

---- PROGRAM ----

main : Program Never Model Msg
main =
  Navigation.program OnLocationChange
    { view = view
    , init = init
    , update = update
    , subscriptions = subscriptions
    }