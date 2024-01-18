defmodule Elform.Utilities.KeyList.MergeTest do
  use ExUnit.Case

  alias Elform.Utilities.KeyList

  describe "when the arguments are valid" do
    test "should return the resulting list" do
      response = KeyList.merge([{:k, 1}], [:k])
      expected_response = [{:k, 1}, :k]
      assert response == expected_response
    end
  end
end
