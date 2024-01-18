defmodule Elform.Validators.Number.PrimeNumberTest do
  use ExUnit.Case

  describe "when there is not a prime number" do
    test "should return a schema error" do
      schema = %{
        label: "number",
        validators: [:prime_number]
      }

      payload = %{"number" => 6}
      response = Elform.validate(schema, payload)

      expected_response =
        %{"number" => [prime_number: "the value should be a prime number"]}

      assert response == expected_response
    end
  end

  describe "when there is a prime number" do
    test "should return ':ok'" do
      schema = %{
        label: "number",
        validators: [:prime_number]
      }

      payload = %{"number" => 11}
      response = Elform.validate(schema, payload)
      expected_response = %{"number" => :ok}

      assert response == expected_response
    end
  end
end
