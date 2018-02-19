module A exposing (Model, init, Msg, update, view)

import Html
import A1
import A2


type alias Version =
    Int


type Model
    = A1Model A1.Model
    | A2Model A2.Model


init : Model
init =
    A1Model A1.init


type Msg
    = A1Msg A1.Model
    | A2Msg A2.Model


update : Msg -> Model -> Model
update msg model =
    case msg of
        A1Msg a1Model ->
            A1Model a1Model

        A2Msg a2Model ->
            A2Model a2Model


view : Version -> Model -> Html.Html Msg
view version model =
    case ( version, model ) of
        ( 1, A1Model a1Model ) ->
            A1.view { toMsg = A1Msg } a1Model

        ( 2, A2Model a2Model ) ->
            A2.view { toMsg = A2Msg } a2Model

        ( 1, A2Model a2Model ) ->
            A1.view { toMsg = A1Msg } A1.init

        ( 2, A1Model a1Model ) ->
            A2.view { toMsg = A2Msg } A2.init

        ( other, _ ) ->
            Html.text "Requested an unknown version of A"
