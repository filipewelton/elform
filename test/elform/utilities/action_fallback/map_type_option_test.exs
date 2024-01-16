defmodule Elform.Utilities.ActionFallback.MapTypeOptionTest do
  use ExUnit.Case
  use Elform.Utilities.ActionFallback, name: :test, type: :map

  describe "call/2" do
    test "when the value is not a map" do
      response = call(nil, %{})
      expected_response = [test: "the value must be a map"]

      assert response == expected_response
    end

    test "when the value is a map" do
      assert_raise(FunctionClauseError, fn ->
        call(%{k: true}, %{k: true})
      end)
    end
  end
end
