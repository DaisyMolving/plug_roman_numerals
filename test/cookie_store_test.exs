defmodule CookieStoreTest do
  use ExUnit.Case
  use Plug.Test

  @opts RomNumRouter.init([])

  test "reads the arabic value given by form in body" do
    conn = conn(:post, "/arabic_numbers", "arabic_number=13")

    assert CookieStore.read_arabic_value(conn) == "13"
  end

  test "stores a cookie" do
    conn = conn(:post, "/arabic_numbers", "arabic_number=6")
    |> CookieStore.store("VI")
    
    assert CookieStore.fetch_value(conn) == "VI"
  end

  test "fetches the expected cookie" do
    conn = conn(:post, "/arabic_numbers", "arabic_number=6")
    |> CookieStore.store("VI")
    |> CookieStore.store("XXXIII")
    
    assert CookieStore.fetch_value(conn) == "XXXIII"
  end

end
