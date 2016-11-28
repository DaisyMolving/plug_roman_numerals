defmodule CookieStore do
  import Plug.Conn

  def store(conn, value) do
    put_resp_cookie(conn, "roman_numeral", value)
  end

  def fetch_value(conn) do
    fetch_cookies(conn).cookies["roman_numeral"]
  end

end
