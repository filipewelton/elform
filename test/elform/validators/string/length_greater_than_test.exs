defmodule Elform.Validators.String.LengthGreaterThanTest do
  use ExUnit.Case

  alias Elform

  describe "when text length is less than 10" do
    test "should return a schema error" do
      schema = %{
        label: "email",
        required: true,
        validators: [length_greater_than: 10]
      }

      payload = %{"email" => Faker.String.base64()}
      response = Elform.validate(schema, payload)

      expected_response = %{
        "email" => [length_greater_than: "the text length should be greater than 10"]
      }

      assert response == expected_response
    end
  end

  describe "when text length is greater than 10" do
    test "should return ':ok'" do
      schema = %{
        label: "email",
        required: true,
        validators: [length_greater_than: 10]
      }

      payload = %{"email" => Faker.String.base64(11)}
      response = Elform.validate(schema, payload)
      expected_response = %{"email" => :ok}

      assert response == expected_response
    end
  end
end
