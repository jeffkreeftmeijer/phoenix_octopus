defmodule Octopus.PageController do
  use Octopus.Web, :controller

  def index(_conn, %{"flip" => "crash"}) do
    raise("Octopus crashed")
  end
  def index(conn, %{"flip" => "left"}) do
    html conn, "<pre>" <> (octopus |> flip) <> "</pre>" <>
    "<p><a href=\"?flip=right\">flip!</a></p>" <>
    "<p><a href=\"?flip=crash\">crash!</a></p>"
  end
  def index(conn, _params) do
    html conn, "<pre>" <> octopus <> "</pre>" <>
    "<p><a href=\"?flip=left\">flip!</a></p>" <>
    "<p><a href=\"?flip=crash\">crash!</a></p>"
  end

  defp octopus do
    octopus = ~S{                      ___                              
                   .-'   `'.                           
                  /         \                          
                  |         ;                          
                  |         |           ___.--,        
         _.._     |0) ~ (0) |    _.---'`__.-( (_.      
  __.--'`_.. '.__.\    '--. \_.-' ,.--'`     `""`      
 ( ,.--'`   ',__ /./;   ;, '.__.'`    __               
 _`) )  .---.__.' / |   |\   \__..--""  """--.,_       
`---' .'.''-._.-'`_./  /\ '.  \ _.-~~~````~~~-._`-.__.'
      | |  .' _.-' |  |  \  \  '.               `~---` 
       \ \/ .'     \  \   '. '-._)                     
        \/ /        \  \    `=.__`~-.                  
        / /\         `) )    / / `"".`\                
  , _.-'.'\ \        / /    ( (     / /                
   `--~`   ) )    .-'.'      '.'.  | (                 
          (/`    ( (`          ) )  '-;                
           `      '-;         (-'                      }
  end

  defp flip(contents) do
    lines = String.split(contents, "\n")
    lines = Enum.map(lines, fn(line) -> String.reverse(line) end)
    octopus = Enum.join(lines, "\n")

    octopus |> String.replace("\\", "TEMP") |>
    String.replace("/", "\\") |>
    String.replace("TEMP", "/") |>
    String.replace("(", "TEMP") |>
    String.replace(")", "(") |>
    String.replace("TEMP", ")")
  end
end
