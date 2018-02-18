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
    = A1Msg A1.Msg
    | A2Msg A2.Msg


update : Msg -> Model -> Model
update msg model =
    case ( msg, model ) of
        ( A1Msg a1Msg, A1Model a1Model ) ->
            A1.update a1Msg a1Model |> A1Model

        ( A2Msg a2Msg, A2Model a2Model ) ->
            A2.update a2Msg a2Model |> A2Model

        ( A2Msg _, A1Model _ ) ->
            Debug.crash "msg A2 does not belong to model A1"

        ( A1Msg _, A2Model _ ) ->
            Debug.crash "msg A1 does not belong to model A2"


view : Version -> Model -> Html.Html Msg
view version model =
    case ( version, model ) of
        ( 1, A1Model a1Model ) ->
            A1.view a1Model |> Html.map A1Msg

        ( 2, A2Model a2Model ) ->
            A2.view a2Model |> Html.map A2Msg

        ( 1, A2Model a2Model ) ->
            Html.text "Oops, requested version 1 but model is version 2!"

        ( 2, A1Model a1Model ) ->
            Html.text "Oops, requested version 2 but model is version 1!"

        ( other, _ ) ->
            Html.text "Requested an unknown version of A"
