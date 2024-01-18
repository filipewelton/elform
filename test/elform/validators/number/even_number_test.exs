defmodule Elform.Validators.Number.EvenNumberTest do
  use ExUnit.Case

  describe "when there is not an even number" do
    test "should return a schema error" do
      schema = %{
        label: "age",
        validators: [:even_number]
      }

      payload = %{"age" => 17}
      response = Elform.validate(schema, payload)
      expected_response = %{"age" => [even_number: "the value should be an even number"]}

      assert response == expected_response
    end
  end

  describe "when there is an even number" do
    test "should return ':ok'" do
      schema = %{
        label: "age",
        validators: [:even_number]
      }

      payload = %{"age" => 18}
      response = Elform.validate(schema, payload)
      expected_response = %{"age" => :ok}

      assert response == expected_response
    end
  end
end
