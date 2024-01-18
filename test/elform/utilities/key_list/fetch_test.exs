defmodule Elform.Utilities.KeyList.FetchTest do
  use ExUnit.Case

  alias Elform.Utilities.KeyList

  describe "when the 'list' argument is empty" do
    test "should throw argument error" do
      assert_raise(KeyError, fn ->
        KeyList.fetch!([], :k)
      end)
    end
  end

  describe "when there is a non-existent key" do
    test "should throw argument error" do
      assert_raise(KeyError, fn ->
        KeyList.fetch!([:a, :b, :c], :k)
      end)
    end
  end

  describe "when there is a valid key" do
    test "should return ':k'" do
      response = KeyList.fetch!([:k, {:l, 1}], :k)
      assert response == :k
    end
  end
end
