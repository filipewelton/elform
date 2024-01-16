defmodule Elform.Utilities.ActionFallback.ListTypeOptionTest do
  use ExUnit.Case
  use Elform.Utilities.ActionFallback, name: :test, type: :list

  describe "call/2" do
    test "when the value is not a list" do
      response = call(nil, [])
      expected_response = [test: "the value must be a list"]

      assert response == expected_response
    end

    test "when the value is a list" do
      assert_raise(FunctionClauseError, fn ->
        call([], [])
      end)
    end
  end
end
