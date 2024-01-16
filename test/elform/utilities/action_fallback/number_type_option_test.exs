defmodule Elform.Utilities.ActionFallback.NumberTypeOptionTest do
  use ExUnit.Case
  use Elform.Utilities.ActionFallback, name: :test, type: :number

  describe "call/2" do
    test "when the value is not a number" do
      response = call(nil, :rand.uniform())
      expected_response = [test: "the value must be a number"]

      assert response == expected_response
    end

    test "when the value is a number" do
      assert_raise(FunctionClauseError, fn ->
        call(:rand.uniform(), :rand.uniform())
      end)
    end
  end

  describe "call/1" do
    test "when the value is not a number" do
      response = call(nil)
      expected_response = [test: "the value must be a number"]

      assert response == expected_response
    end

    test "when the value is a number" do
      assert_raise(FunctionClauseError, fn ->
        call(:rand.uniform())
      end)
    end
  end
end
