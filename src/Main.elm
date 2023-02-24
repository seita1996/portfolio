module Main exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)


---- MODEL ----


type alias Model =
    {}


init : ( Model, Cmd Msg )
init =
    ( {}, Cmd.none )



---- UPDATE ----


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    div []
        [ img [ src "/logo.svg", class "logo" ] [] 
        , h1 [] [ text "Seitaro" ]
        , div [] [ text "A software developer based in Japan." ]
        , div [ class "flex" ]
            [
                div [ class "sns-card" ] [ a [ href "https://github.com/seita1996" ] [ text "GitHub" ] ]
            ,   div [ class "sns-card" ] [ a [ href "https://zenn.dev/seita1996" ] [ text "Zenn" ] ]
            ,   div [ class "sns-card" ] [ a [ href "https://twitter.com/seita_1996" ] [ text "Twitter" ] ]
            ,   div [ class "sns-card" ] [ a [ href "https://note.com/seita1996" ] [ text "Note" ] ]
            ]
        ]



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }
