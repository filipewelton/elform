defmodule Elform.Validators.Number.NumericEqualityTest do
  use ExUnit.Case

  @number :rand.uniform(99)

  describe "when the value is not equal to #{@number}" do
    test "should return a schema error" do
      schema = %{
        label: "age",
        validators: [numeric_equality: @number]
      }

      payload = %{"age" => @number - 1}
      response = Elform.validate(schema, payload)

      expected_response = %{
        "age" => [numeric_equality: "the value should be equal to #{@number}"]
      }

      assert response == expected_response
    end
  end

  describe "when the value is equal to #{@number}" do
    test "should return ':ok'" do
      schema = %{
        label: "age",
        validators: [numeric_equality: @number]
      }

      payload = %{"age" => @number}
      response = Elform.validate(schema, payload)
      expected_response = %{"age" => :ok}

      assert response == expected_response
    end
  end
end
