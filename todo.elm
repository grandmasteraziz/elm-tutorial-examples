module Main exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (type_ , value,attribute,class)
import Html.Events exposing (onClick,onInput)


main =
  Browser.sandbox { init = init, update = update, view = view }
     

type alias Model = 
        { todo : String 
          ,todos : List String}


--model 
init : Model 
init = 
    { 
        todo = "" 
       ,todos = []
    }

stylesheet = 
    let 
        tag = 
            "link"

        attrs =
            [
            attribute  "Rel" "stylesheet"
            ,attribute "property" "stylesheet"
            ,attribute "href" "https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
            ]

        children = 
            []

    in 
        node tag attrs children



type Msg = 
    UpdateTodo String 
    | AddTodo
    | RemoveAll 
    | RemoveItem String

--update
update : Msg -> Model -> Model
update msg model =
    case msg of
        UpdateTodo text -> 
            {model | todo = text }
        AddTodo -> 
            {model | todos = model.todo :: model.todos }    
        RemoveAll -> 
            {model | todos = []}    
        RemoveItem text -> 
            {model | todos = List.filter (\x -> x /= text) model.todos }    
            
            

-- view
todoItem : String -> Html Msg
todoItem todo =
    li [][text todo 
    , button[ onClick (RemoveItem todo)][text "x"]]

todoList : List String -> Html Msg
todoList todos = 
    let
     child = 
        List.map todoItem todos
    in 
     ul [] child 


view model=
    div [class "jumbotron"][
        stylesheet
        ,input[type_ "text" 
        , onInput UpdateTodo 
        ,value model.todo
        ][]
        ,button [onClick AddTodo , class "btn btn-primary"][text "Submit"]
        ,button [onClick RemoveAll , class "btn btn-danger"][text "Remove All"]
        ,div[][todoList  model.todos]
    ]