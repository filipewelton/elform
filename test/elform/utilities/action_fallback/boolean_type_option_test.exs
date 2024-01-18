defmodule Elform.Utilities.ValidatorActionFallback.BooleanTypeOptionTest do
  use ExUnit.Case
  use Elform.Utilities.ValidatorActionFallback, name: :test, type: :boolean

  describe "call/2" do
    test "when the value is not a boolean" do
      response = call(nil, true)
      expected_response = [test: "the value should be a boolean"]

      assert response == expected_response
    end

    test "when the value is a boolean" do
      assert_raise(FunctionClauseError, fn ->
        call(true, false)
      end)
    end
  end
end
