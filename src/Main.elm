module Main exposing (main)

import Html
import Html.Events
import Html.Attributes
import A


-- import B


type alias Version =
    Int


type alias Model =
    { a : A.Model

    -- , b : B.Model
    , version : Version
    , error : String
    }


init : Model
init =
    { a = A.init

    -- , b = B.init
    , version = 1
    , error = ""
    }


type Msg
    = AMsg A.Msg
    | ChangeVersion String



-- | BMsg B.Msg


update : Msg -> Model -> Model
update msg model =
    case msg of
        AMsg aMsg ->
            { model | a = A.update aMsg model.a }

        ChangeVersion version ->
            case version of
                "1" ->
                    { model | version = 1, error = "" }

                "2" ->
                    { model | version = 2, error = "" }

                version ->
                    { model | error = "Version '" ++ version ++ "' is not a valid version number" }



-- BMsg bMsg ->
--     B.update bMsg model.b


view : Model -> Html.Html Msg
view model =
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
            [ A.view model.version model.a |> Html.map AMsg ]
        ]


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = init
        , view = view
        , update = update
        }
