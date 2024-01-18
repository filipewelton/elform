defmodule Elform.Utilities.ValidatorActionFallback.StringTypeOptionTest do
  use ExUnit.Case
  use Elform.Utilities.ValidatorActionFallback, name: :test, type: :string

  describe "call/2" do
    test "when the value is not a string" do
      response = call(nil, Faker.String.base64())
      expected_response = [test: "the value should be a string"]

      assert response == expected_response
    end

    test "when the value is a string" do
      assert_raise(FunctionClauseError, fn ->
        call(Faker.String.base64(), Faker.String.base64())
      end)
    end
  end
end
