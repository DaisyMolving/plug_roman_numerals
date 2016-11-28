defmodule RomNumRouter do
  use Plug.Router
  import Plug.Conn

  plug :match
  plug :dispatch


  get "/" do 
    conn
    |> send_resp(200, TemplateDisplay.template_index(CookieStore.fetch_value(conn)))
  end

  post "/arabic_numbers" do
    value = CookieStore.read_arabic_value(conn)
    CookieStore.store(conn, value)
    |> redirect(to: "/")
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
