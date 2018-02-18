module A1 exposing (Model, init, Msg, update, view)

import Html


type Model
    = A1
    | B1
    | C1


init : Model
init =
    A1


type Msg
    = M1
    | M2
    | M3


update : Msg -> Model -> Model
update msg model =
    model


view : Model -> Html.Html Msg
view model =
    Html.text "A1"
