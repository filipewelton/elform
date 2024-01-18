defmodule Elform.Operators.AndTest do
  use ExUnit.Case

  alias Elform.Operators.And

  describe "when the value does not match one of the conditions" do
    test "should return an error: the text length should be greater than 20" do
      text = Faker.String.base64(8)
      response = And.call(text, [length_greater_than: 20, text_equality: text])

      expected_response =
        [length_greater_than: "the text length should be greater than 20"]

      assert response == expected_response
    end
  end

  describe "when the value matches one of the conditions" do
    test "should return ':ok'" do
      text = "text"
      response = And.call(text, [length_greater_than: 3, text_equality: text])

      assert response == :ok
    end
  end

  describe "when the 'validators' argument is invalid" do
    test "should throw argument error" do
      text = Faker.String.base64()
      assert_raise(ArgumentError, fn -> And.call(text, %{}) end)
    end
  end
end
