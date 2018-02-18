module A exposing (Model, init, Msg, update, view)

import Html
import A1
import A2


type alias Version =
    Int


type alias Model =
    { version1 : A1.Model
    , version2 : A2.Model
    }


init : Model
init =
    { version1 = A1.init, version2 = A2.init }


type Msg
    = A1Msg A1.Msg
    | A2Msg A2.Msg


update : Msg -> Model -> Model
update msg model =
    case msg of
        A1Msg a1Msg ->
            { model | version1 = A1.update a1Msg model.version1 }

        A2Msg a2Msg ->
            { model | version2 = A2.update a2Msg model.version2 }


view : Version -> Model -> Html.Html Msg
view version model =
    case version of
        1 ->
            A1.view model.version1 |> Html.map A1Msg

        2 ->
            A2.view model.version2 |> Html.map A2Msg

        other ->
            Html.text "Requested an unknown version of A"
