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


view : Model -> Html.Html Msg
view model =
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
            , Html.Events.onClick ToggleColor
            ]
            [ Html.text "A2"
            ]
