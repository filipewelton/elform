defmodule Elform.Operators.OrTest do
  use ExUnit.Case

  alias Elform.Operators.Or

  describe "when the value does not match any of the conditions" do
    test "should return multiple errors" do
      expected_text = "text"
      another_text = "another text"

      response =
        Or.call(another_text, length_greater_than: 20, text_equality: expected_text)

      expected_response = [
        length_greater_than: "the text length should be greater than 20",
        text_equality: "text should be equal to '#{expected_text}'"
      ]

      assert response == expected_response
    end
  end

  describe "when the value doe match all conditions" do
    test "when the value matches one of the conditions" do
      text = Faker.String.base64()
      response = Or.call(text, length_greater_than: 20, text_equality: text)

      assert response == :ok
    end
  end

  describe "when the 'validators' argument is invalid" do
    test "should throw argument error" do
      text = Faker.String.base64()
      assert_raise(ArgumentError, fn -> Or.call(text, %{}) end)
    end
  end
end
