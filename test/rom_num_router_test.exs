defmodule RomNumRouterTest do
  use ExUnit.Case
  use Plug.Test

  @opts RomNumRouter.init([])

  test "goes to index page" do
    conn = conn(:get, "/", TemplateDisplay.template_index("hello"))
    conn = RomNumRouter.call(conn, @opts)

    assert conn.state == :sent
    assert conn.status == 200
  end

  test "if page not found return 404" do
    conn = conn(:get, "/weird-request", "Sorry, page not found")
    conn = RomNumRouter.call(conn, @opts)

    assert conn.state == :sent
    assert conn.status == 404

  end

  test "index page displays eex html template as response body" do
    conn = conn(:get, "/", TemplateDisplay.template_index("hello"))
    conn = RomNumRouter.call(conn, @opts)

    assert conn.resp_body =~ "Arabic Number"
  end

  test "input from html form is given in response body" do
    conn = conn(:post, "/arabic-numbers", "arabic_number=6")
    conn = RomNumRouter.call(conn, @opts)
    {:ok, body, _} = read_body(conn)

    assert body == "arabic_number=6"
  end

  test "redirects to given location" do
    conn = conn(:post, "/arabic-numbers", "arabic_number=6")
    conn = RomNumRouter.redirect(conn, [to: "/"])

    assert conn.state == :set
    assert conn.status == 302
  end

  test "goes to Arabic numbers page and redirects" do
    conn = conn(:post, "/arabic-numbers", "arabic_number=6")
    conn = RomNumRouter.call(conn, @opts)

    assert conn.state == :set
    assert conn.status == 302
  end

  test "stored cookie is passed to new conn when redirected" do
    old_conn = conn(:post, "/arabic-numbers", "arabic_number=123")
    |> RomNumRouter.call(@opts)
    new_conn = conn(:get, "/", TemplateDisplay.template_index(CookieStore.fetch_value(old_conn)))
    |> RomNumRouter.call(@opts)
    conn = recycle_cookies(new_conn, old_conn)

    assert CookieStore.fetch_value(conn) =~ "123"
  end

end
