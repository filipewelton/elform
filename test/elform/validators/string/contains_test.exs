defmodule Elform.Validators.String.ContainsTest do
  use ExUnit.Case

  describe "when the value does not contain 'Doe'" do
    test "should return a schema error" do
      schema = %{
        label: "name",
        required: true,
        validators: [contains: "Doe"]
      }

      payload = %{"name" => "John Wick"}
      response = Elform.validate(schema, payload)

      assert %{"name" => [contains: "the value does not contains Doe"]} = response
    end
  end

  describe "when all arguments are valid" do
    test "should return ':ok'" do
      schema = %{
        label: "name",
        required: true,
        validators: [contains: "Doe"]
      }

      payload = %{"name" => "John Doe"}
      response = Elform.validate(schema, payload)
      expected_response = %{"name" => :ok}

      assert response == expected_response
    end
  end
end
