module Main exposing (main)

import Html
import Html.Events
import Html.Attributes
import A1
import A2


-- import B


type alias Version =
    Int


type AModel
    = A1Model A1.Model
    | A2Model A2.Model


type alias Model =
    { a : AModel

    -- , b : B.Model
    , version : Version
    , error : String
    }


init : Model
init =
    { a = A1Model A1.init

    -- , b = B.init
    , version = 1
    , error = ""
    }


type Msg
    = A1Msg A1.Msg
    | A2Msg A2.Msg
    | ChangeVersion String



-- | BMsg B.Msg


update : Msg -> Model -> Model
update msg model =
    case ( msg, model.a ) of
        ( A1Msg a1Msg, A1Model a1Model ) ->
            { model | a = A1Model (A1.update a1Msg a1Model) }

        ( A2Msg a2Msg, A2Model a2Model ) ->
            { model | a = A2Model (A2.update a2Msg a2Model) }

        ( A1Msg a1Msg, A2Model _ ) ->
            Debug.crash "Received msg for A1 but state is A2"

        ( A2Msg a2Msg, A1Model _ ) ->
            Debug.crash "Received msg for A2 but state is A1"

        ( ChangeVersion version, _ ) ->
            case version of
                "1" ->
                    { model | version = 1, a = A1Model A1.init, error = "" }

                "2" ->
                    { model | version = 2, a = A2Model A2.init, error = "" }

                version ->
                    { model | error = "Version '" ++ version ++ "' is not a valid version number" }



-- BMsg bMsg ->
--     B.update bMsg model.b


view : Model -> Html.Html Msg
view model =
    let
        aView =
            case ( model.version, model.a ) of
                ( 1, A1Model a1Model ) ->
                    A1.view a1Model |> Html.map A1Msg

                ( 2, A2Model a2Model ) ->
                    A2.view a2Model |> Html.map A2Msg

                other ->
                    Debug.crash "Unknown version of A"
    in
        Html.div
            []
            [ Html.div
                []
                [ Html.select
                    [ Html.Events.onInput ChangeVersion
                    ]
                    [ Html.option [ Html.Attributes.value "1" ] [ Html.text "Version 1" ]
                    , Html.option [ Html.Attributes.value "2" ] [ Html.text "Version 2" ]
                    ]
                , Html.text model.error
                ]
            , Html.div
                []
                [ aView ]
            ]


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = init
        , view = view
        , update = update
        }
