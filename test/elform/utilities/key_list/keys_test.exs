defmodule Elform.Utilities.KeyList.KeysTest do
  use ExUnit.Case

  alias Elform.Utilities.KeyList

  describe "when there is an empty list" do
    test "should return an empty list" do
      response = KeyList.keys([])
      assert response === []
    end
  end

  describe "when there is a non-empty list" do
    test "should return keys" do
      list = [a: 1, b: 2]
      response = KeyList.keys(list)
      assert response === [:a, :b]
    end
  end
end
