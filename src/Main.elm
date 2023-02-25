module Main exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Http


---- MODEL ----



type Model
    = Failure
    | Loading
    | Success String

init : () -> (Model, Cmd Msg)
init _ =
    ( Loading
    , Http.get
        { url = "https://elm-lang.org/assets/public-opinion.txt"
        , expect = Http.expectString GotText
        }
    )



---- UPDATE ----



type Msg
    = GotText (Result Http.Error String)


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        GotText result ->
            case result of
                Ok fullText ->
                    (Success fullText, Cmd.none)

                Err _ ->
                    (Failure, Cmd.none)



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



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
        , div [] [ posts model ]
        ]


posts : Model -> Html Msg
posts model =
    case model of
        Failure ->
            text "I was unable to load your book."

        Loading ->
            text "Loading..."

        Success fullText ->
            pre [] [ text fullText ]



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }
