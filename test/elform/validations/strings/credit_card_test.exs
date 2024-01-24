defmodule Elform.Validations.Strings.CreditCardTest do
  use ExUnit.Case
  use Elform

  alias Elform.SchemaFieldError

  describe "when the value is a SchemaFieldError" do
    test "then return an error message" do
      error = %SchemaFieldError{
        arguments: [],
        reason: "unknown error",
        value: nil
      }

      response =
        %{card_number: credit_card(error)}
        |> Elform.parse_errors()

      expected_response = %{card_number: "unknown error"}

      assert response == expected_response
    end
  end

  describe "when the value is not a string" do
    test "then return an error message" do
      response =
        %{card_number: credit_card(nil)}
        |> Elform.parse_errors()

      expected_response = %{card_number: "the value must be a string"}

      assert response == expected_response
    end
  end

  describe "when the value is not a valid credit card number" do
    test "then return an error message" do
      value = Faker.Beer.name()

      response =
        %{card_number: credit_card(value)}
        |> Elform.parse_errors()

      expected_response = %{card_number: "the value is not a valid credit card number"}

      assert response == expected_response
    end
  end

  describe "when the value is a valid credit card number" do
    test "then return ok" do
      value = "5444205200540266"

      response =
        %{card_number: credit_card(value)}
        |> Elform.parse_errors()

      expected_response = %{card_number: :ok}

      assert response == expected_response
    end
  end
end
