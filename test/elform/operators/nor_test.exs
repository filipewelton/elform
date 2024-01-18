defmodule Elform.Operators.NorTest do
  use ExUnit.Case

  describe "when the 'validators' argument does not a list" do
    test "should throw argument error" do
      schema = %{
        label: "text",
        validators: [
          nor: nil
        ]
      }

      payload = %{}

      assert_raise(ArgumentError, fn -> Elform.validate(schema, payload) end)
    end
  end

  describe "when one of the conditions is valid" do
    test "should return a schema error" do
      text = Faker.Lorem.word()

      schema = %{
        label: "text",
        validators: [
          nor: [text_equality: text, length_greater_than: 255]
        ]
      }

      payload = %{"text" => text}
      response = Elform.validate(schema, payload)

      expected_response =
        %{"text" => [length_greater_than: "the text length should be greater than 255"]}

      assert response == expected_response
    end
  end
end
