defmodule Elform.Validations.Numbers.OddNumberTest do
  use ExUnit.Case
  use Elform

  alias Elform.SchemaFieldError

  describe "when the value is a SchemaFieldError" do
    test "then return an error message" do
      value = %SchemaFieldError{
        arguments: [],
        reason: "unknown error",
        value: nil
      }

      response =
        %{card_number: odd_number(value)}
        |> Elform.parse_errors()

      expected_response = %{card_number: "unknown error"}

      assert response == expected_response
    end
  end

  describe "when the value is not a number" do
    test "then return an error message" do
      response =
        %{card_number: odd_number(true)}
        |> Elform.parse_errors()

      expected_response = %{card_number: "the value must be a number"}

      assert response == expected_response
    end
  end

  describe "when the value is not an odd number" do
    test "then return an error message" do
      response =
        %{card_number: odd_number(2)}
        |> Elform.parse_errors()

      expected_response = %{card_number: "the value must be a odd number"}

      assert response == expected_response
    end
  end

  describe "when the value is an odd number" do
    test "then return an error message" do
      response =
        %{card_number: odd_number(3)}
        |> Elform.parse_errors()

      expected_response = %{card_number: :ok}

      assert response == expected_response
    end
  end
end
