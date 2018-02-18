module A2 exposing (Model, init, Msg, update, view)

import Html


type Model
    = A2
    | B2
    | C2


init : Model
init =
    A2


type Msg
    = M1
    | M2
    | M3


update : Msg -> Model -> Model
update msg model =
    model


view : Model -> Html.Html Msg
view model =
    Html.text "A2"
