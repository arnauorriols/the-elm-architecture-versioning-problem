module A1 exposing (Model, init, Msg, update, view)

import Html
import Html.Attributes
import Html.Events


type Model
    = Small
    | Big


init : Model
init =
    Small


type Msg
    = ToggleSize


update : Msg -> Model -> Model
update msg model =
    case msg of
        ToggleSize ->
            case model of
                Small ->
                    Big

                Big ->
                    Small


view : Model -> Html.Html Msg
view model =
    let
        fontSize =
            case model of
                Small ->
                    "1rem"

                Big ->
                    "2rem"
    in
        Html.span
            [ Html.Attributes.style [ ( "font-size", fontSize ) ]
            , Html.Events.onClick ToggleSize
            ]
            [ Html.text "A1" ]
