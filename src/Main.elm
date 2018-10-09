module Main exposing (..)

import Browser
import Html exposing (Html)
import Html.Attributes as Attrs
import Html.Events as Events


-- MODEL


type alias Model =
    { newName : String
    , newGreeting : String
    , entries : List Entry
    }


init : Model
init =
    { newName = ""
    , newGreeting = ""
    , entries =
        [ { greeting = "Hello, STL Elm"
          , author = "Brian"
          }
        , { greeting = "Hey, there's the arch"
          , author = "Everyone on I-64 Westbound"
          }
        ]
    }


type alias Entry =
    { greeting : String
    , author : String
    }



-- UPDATE


type Msg
    = NewName String
    | NewGreeting String
    | SubmitGreeting


update : Msg -> Model -> Model
update msg model =
    case msg of
        NewName name ->
            { model | newName = name }

        NewGreeting greeting ->
            { model | newGreeting = greeting }

        SubmitGreeting ->
            { model
                | newName = ""
                , newGreeting = ""
                , entries =
                    { greeting = model.newGreeting
                    , author = model.newName
                    }
                        :: model.entries
            }



-- VIEW


view : Model -> Html Msg
view model =
    Html.main_ []
        [ Html.h1 [] [ Html.text "Please sign my guest book!" ]
        , Html.hr [] []
        , Html.form
            [ Events.onSubmit SubmitGreeting ]
            [ Html.p []
                [ Html.label
                    [ Attrs.for "name" ]
                    [ Html.text "Your Name" ]
                , Html.input
                    [ Attrs.type_ "text"
                    , Attrs.id "name"
                    , Events.onInput NewName
                    , Attrs.value model.newName
                    ]
                    []
                ]
            , Html.p []
                [ Html.label
                    [ Attrs.for "greeting" ]
                    [ Html.text "Your Greeting" ]
                , Html.input
                    [ Attrs.type_ "text"
                    , Attrs.id "greeting"
                    , Events.onInput NewGreeting
                    , Attrs.value model.newGreeting
                    ]
                    []
                ]
            , Html.button [ Attrs.type_ "submit" ] [ Html.text "SIGN IT" ]
            ]
        , Html.hr [] []
        , Html.ul [] (List.map entry model.entries)
        ]


entry : Entry -> Html msg
entry { greeting, author } =
    Html.li []
        [ Html.text greeting
        , Html.text ("-- " ++ author)
        ]



-- MAIN


main =
    Browser.sandbox
        { init = init
        , update = update
        , view = view
        }
