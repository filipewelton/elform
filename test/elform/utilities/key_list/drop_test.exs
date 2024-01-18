defmodule Elform.Utilities.KeyList.DropTest do
  use ExUnit.Case

  alias Elform.Utilities.KeyList

  @keys [:a, :b]

  describe "when the first argument is empty" do
    test "should return an empty list" do
      response = KeyList.drop([], @keys)
      assert response == []
    end
  end

  describe "when the list contains valid keys" do
    test "should return the resulting keys" do
      list = @keys ++ [:c, :d]
      response = KeyList.drop(list, @keys)
      assert response === [:c, :d]
    end
  end
end
