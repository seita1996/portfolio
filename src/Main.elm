module Main exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (class, src, href)
import Http
import Json.Decode as D



---- MODEL ----



type Model
    = Failure
    | Loading
    | Success ZennPosts

type alias ZennPosts =
    { items : List Post }

type alias Post =
    { title : String
    , pubDate : String
    , link : String
    , description : String
    }

init : () -> (Model, Cmd Msg)
init _ =
    (Loading, getZennPosts)



---- UPDATE ----



type Msg
    = GotZennPosts (Result Http.Error ZennPosts)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        GotZennPosts result ->
            case result of
                Ok zennposts ->
                    (Success zennposts, Cmd.none)

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

postComponent : Post -> Html msg
postComponent post =
    div [ class "post-box" ]
        [ blockquote [] [ a [ href post.link ] [ text post.title ] ]
        , p [] [ text post.description ]
        , p [] [ text post.pubDate ]
        ]

posts : Model -> Html Msg
posts model =
    case model of
        Failure ->
            text "Something went wrong."

        Loading ->
            text "Loading..."

        Success zennposts ->
            div []
                [ div [] (zennposts.items |> List.map postComponent)
                ]



---- HTTP ----



getZennPosts : Cmd Msg
getZennPosts =
    Http.get
        { url = "https://api.rss2json.com/v1/api.json?rss_url=https://zenn.dev/seita1996/feed"
        , expect = Http.expectJson GotZennPosts zennDecoder
        }

zennDecoder : D.Decoder ZennPosts
zennDecoder =
    D.map ZennPosts
        (D.field "items" (D.list postDecoder))

postDecoder : D.Decoder Post
postDecoder =
    D.map4 Post
        (D.field "title" D.string)
        (D.field "pubDate" D.string)
        (D.field "link" D.string)
        (D.field "description" D.string)



---- PROGRAM ----



main : Program () Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }
