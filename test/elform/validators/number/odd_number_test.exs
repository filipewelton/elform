defmodule Elform.Validators.Number.OddNumberTest do
  use ExUnit.Case

  describe "when there is not an odd number" do
    test "should return a schema error" do
      schema = %{
        label: "age",
        validators: [:odd_number]
      }

      payload = %{"age" => 18}
      response = Elform.validate(schema, payload)
      expected_response = %{"age" => [odd_number: "the value should be an odd number"]}

      assert response == expected_response
    end
  end

  describe "when there is an odd number" do
    test "should return ':ok'" do
      schema = %{
        label: "age",
        validators: [:odd_number]
      }

      payload = %{"age" => 17}
      response = Elform.validate(schema, payload)
      expected_response = %{"age" => :ok}

      assert response == expected_response
    end
  end
end
