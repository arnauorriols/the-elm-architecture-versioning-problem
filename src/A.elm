module A exposing (Model, init, Msg, update, view)

import Html
import Html.Attributes
import Html.Events


type alias Version =
    Int


type Size
    = Small
    | Big


type Color
    = Red
    | Blue


type alias Model =
    { size : Size
    , color : Color
    }


init : Model
init =
    { size = Small
    , color = Red
    }


type Msg
    = ToggleColor
    | ToggleSize


update : Msg -> Model -> Model
update msg model =
    case msg of
        ToggleColor ->
            case model.color of
                Red ->
                    { model | color = Blue }

                Blue ->
                    { model | color = Red }

        ToggleSize ->
            case model.size of
                Small ->
                    { model | size = Big }

                Big ->
                    { model | size = Small }


view : Version -> Model -> Html.Html Msg
view version model =
    case version of
        1 ->
            view1 { onClick = ToggleSize } model.size

        2 ->
            view2 { onClick = ToggleColor } model.color

        other ->
            Html.text "Requested an unknown version of A"



-- VERSION 1


type alias Config1 msg =
    { onClick : msg
    }


view1 : Config1 msg -> Size -> Html.Html msg
view1 config size =
    let
        fontSize =
            case size of
                Small ->
                    "1rem"

                Big ->
                    "2rem"
    in
        Html.span
            [ Html.Attributes.style [ ( "font-size", fontSize ) ]
            , Html.Events.onClick config.onClick
            ]
            [ Html.text "A1" ]



-- VERSION 2


type alias Config2 msg =
    { onClick : msg
    }


view2 : Config2 msg -> Color -> Html.Html msg
view2 config color =
    let
        backgroundColor =
            case color of
                Red ->
                    "red"

                Blue ->
                    "blue"
    in
        Html.span
            [ Html.Attributes.style [ ( "background-color", backgroundColor ) ]
            , Html.Events.onClick config.onClick
            ]
            [ Html.text "A2"
            ]
