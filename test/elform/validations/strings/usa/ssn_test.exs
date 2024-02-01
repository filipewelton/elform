defmodule Elform.Validations.Strings.Usa.SsnTest do
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
        %{ssn: usa_ssn(error)}
        |> Elform.parse_errors()

      expected_response = %{ssn: "unknown error"}

      assert response == expected_response
    end
  end

  describe "when the value is not a string" do
    test "then return an error message" do
      response =
        %{ssn: usa_ssn(nil)}
        |> Elform.parse_errors()

      expected_response = %{ssn: "the value must be a string"}

      assert response == expected_response
    end
  end

  describe "when the value is not a valid SSN" do
    test "then return an error message" do
      value = Faker.String.base64()

      response =
        %{ssn: usa_ssn(value)}
        |> Elform.parse_errors()

      expected_response = %{ssn: "the value is not a valid SSN"}

      assert response == expected_response
    end
  end

  describe "when the value is a valid SSN" do
    test "then return ok" do
      value = "231-22-1234"

      response =
        %{ssn: usa_ssn(value)}
        |> Elform.parse_errors()

      expected_response = %{ssn: :ok}

      assert response == expected_response
    end
  end
end
