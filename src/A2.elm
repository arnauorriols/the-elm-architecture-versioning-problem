module A2 exposing (Model, init, Msg, update, view)

import Html
import Html.Attributes
import Html.Events


type Model
    = Red
    | Blue


init : Model
init =
    Red


type Msg
    = ToggleColor


update : Msg -> Model -> Model
update msg model =
    case msg of
        ToggleColor ->
            case model of
                Red ->
                    Blue

                Blue ->
                    Red


type alias Config msg =
    { toMsg : Model -> msg }


view : Config msg -> Model -> Html.Html msg
view config model =
    let
        backgroundColor =
            case model of
                Red ->
                    "red"

                Blue ->
                    "blue"
    in
        Html.span
            [ Html.Attributes.style [ ( "background-color", backgroundColor ) ]
            , Html.Events.onClick <| config.toMsg <| update ToggleColor model
            ]
            [ Html.text "A2"
            ]
