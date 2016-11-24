defmodule ConverterTest do
  use ExUnit.Case

  test "a 0 returns an empty string" do
    assert Converter.convert(0) == ""
  end

  test "a 1 returns an I" do
    assert Converter.convert(1) == "I"
  end

  test "a 2 returns a II" do
    assert Converter.convert(2) == "II"
  end

  test "a 3 returns a III" do
    assert Converter.convert(3) == "III"
  end

  test "a 5 returns a V" do
    assert Converter.convert(5) == "V"
  end

  test "a 6 returns a VI" do
    assert Converter.convert(6) == "VI"
  end

  test "a 7 returns a VII" do
    assert Converter.convert(7) == "VII"
  end

  test "a 10 returns an X" do
    assert Converter.convert(10) == "X"
  end

  test "an 11 returns XI" do
    assert Converter.convert(11) == "XI"
  end

  test "4 returns IV" do
    assert Converter.convert(4) == "IV"
  end

  test "9 returns IX" do
    assert Converter.convert(9) == "IX"
  end

  test "18 returns XVIII" do
    assert Converter.convert(18) == "XVIII"
  end

  test "20 returns XX" do
    assert Converter.convert(20) == "XX"
  end

  test "40 returns XL" do
    assert Converter.convert(40) == "XL"
  end

  test "50 returns L" do
    assert Converter.convert(50) == "L"
  end

end
