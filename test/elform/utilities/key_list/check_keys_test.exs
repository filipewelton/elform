defmodule Elform.Utilities.KeyList.CheckKeysTest do
  use ExUnit.Case

  alias Elform.Utilities.KeyList

  describe "when there is an empty list" do
    test "should return an empty list" do
      response = KeyList.check_keys!([])
      assert response == :ok
    end
  end

  describe "when the argument is not a list" do
    test "should throw argument error" do
      assert_raise(ArgumentError, fn -> KeyList.check_keys!(nil) end)
    end
  end

  describe "when there is a list with invalid keys" do
    test "should throw argument error" do
      list = [a: 1, b: 2]
      assert_raise(ArgumentError, fn -> KeyList.check_keys!(list) end)
    end
  end

  describe "when there is a valid list" do
    test "should return ':ok'" do
      list = [:length, :length_greater_than]
      response = KeyList.check_keys!(list)

      assert response == :ok
    end
  end
end
