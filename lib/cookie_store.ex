defmodule CookieStore do
  import Plug.Conn

  def read_arabic_value(conn) do
    {:ok, body, _} = Plug.Conn.read_body(conn)
    Enum.at(Regex.run(~r/\d+/, body), 0)
  end

  def store(conn, value) do
    put_resp_cookie(conn, "roman_numeral", value)
  end

  def fetch_value(conn) do
    fetch_cookies(conn).cookies["roman_numeral"]
  end

end
