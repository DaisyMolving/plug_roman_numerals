defmodule RomNumRouter do
  use Plug.Router
  import Plug.Conn

  plug :match
  plug :dispatch


  get "/" do 
    send_resp(conn, 200, TemplateDisplay.template_index)
  end

  post "/arabic_numbers" do
    send_resp(conn, 200, "")
  end

  match _ do
    send_resp(conn, 404, "Sorry, page not found")
  end

  def redirect(conn, [to: to]) do
    conn
    |> put_resp_header("location", to)
    |> resp(302, "")
    |> halt
  end
end
