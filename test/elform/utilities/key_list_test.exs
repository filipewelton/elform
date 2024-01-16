defmodule Elform.Utilities.KeyListTest do
  use ExUnit.Case

  alias Elform.Utilities.KeyList

  describe "valid?/1" do
    test "when there is an empty list" do
      response = KeyList.valid?([])
      assert response
    end

    test "when the argument is not list" do
      response = KeyList.valid?(nil)
      assert not response
    end

    test "when there is a non-empty list" do
      list = [a: 1, b: 2]
      response = KeyList.valid?(list)
      assert response
    end
  end

  describe "keys/1" do
    test "when there is an empty list" do
      response = KeyList.keys([])
      assert response === []
    end

    test "when there is a non-empty list" do
      list = [a: 1, b: 2]
      response = KeyList.keys(list)
      assert response === [:a, :b]
    end
  end

  describe "drop/2" do
    @keys [:a, :b]

    test "when the first argument is empty" do
      response = KeyList.drop([], @keys)
      assert response == []
    end

    test "when the list has invalid keys" do
      list = @keys ++ [:c, :d]
      response = KeyList.drop(list, @keys)
      assert response === [:c, :d]
    end
  end
end
