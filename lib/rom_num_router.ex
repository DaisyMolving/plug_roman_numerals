defmodule RomNumRouter do
  use Plug.Router
  import Plug.Conn

  plug :match
  plug :dispatch


  get "/" do 
    send_resp(conn, 200, TemplateDisplay.template_index)
  end

  post "/arabic_numbers" do
    {:ok, body, _} = read_body(conn)
    send_resp(conn, 200, "")
  end

  match _ do
    send_resp(conn, 404, "Sorry, page not found")
  end
end
