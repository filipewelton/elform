defmodule Elform.Validators.String.LengthLessThanTest do
  use ExUnit.Case

  describe "when text length is greater than 10" do
    test "should return a schema error" do
      schema = %{
        label: "email",
        required: false,
        validators: [length_less_than: 10]
      }

      payload = %{"email" => Faker.String.base64(10)}
      response = Elform.validate(schema, payload)

      expected_response = %{
        "email" => [length_less_than: "the text length should be less than 10"]
      }

      assert response == expected_response
    end
  end

  describe "when text length is less than 10" do
    test "should return ':ok'" do
      schema = %{
        label: "email",
        required: true,
        validators: [length_less_than: 10]
      }

      payload = %{"email" => Faker.String.base64(9)}
      response = Elform.validate(schema, payload)
      expected_response = %{"email" => :ok}

      assert response == expected_response
    end
  end
end
