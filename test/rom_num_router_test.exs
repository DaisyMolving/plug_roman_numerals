defmodule RomNumRouterTest do
  use ExUnit.Case
  use Plug.Test

  @opts RomNumRouter.init([])

  test "goes to index page" do
    conn = conn(:get, "/", TemplateDisplay.template_index)
    conn = RomNumRouter.call(conn, @opts)

    assert conn.state == :sent
    assert conn.status == 200
  end

  test "go to Arabic numbers page" do
    conn = conn(:post, "/arabic_numbers", "")
    conn = RomNumRouter.call(conn, @opts)

    assert conn.state == :sent
    assert conn.status == 200
  end

  test "if page not found return 404" do
    conn = conn(:get, "/weird_request", "Sorry, page not found")
    conn = RomNumRouter.call(conn, @opts)

    assert conn.state == :sent
    assert conn.status == 404

  end

  test "index page displays eex html template as response body" do
    conn = conn(:get, "/", TemplateDisplay.template_index)
    conn = RomNumRouter.call(conn, @opts)

    assert conn.resp_body =~ "Arabic Number"
  end

  test "input from html form is given in response body" do
    conn = conn(:post, "/arabic_numbers", "arabic_number=6")
    conn = RomNumRouter.call(conn, @opts)
    {:ok, body, _} = read_body(conn)

    assert body == "arabic_number=6"
  end

  test "redirects to given location" do
    conn = conn(:post, "/arabic_numbers", "arabic_number=6")
    conn = RomNumRouter.redirect(conn, [to: "/"])

    assert conn.state == :set
    assert conn.status == 302
  end

end
