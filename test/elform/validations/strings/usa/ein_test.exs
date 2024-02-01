defmodule Elform.Validations.Strings.Usa.EinTest do
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
        %{ein: usa_ein(error)}
        |> Elform.parse_errors()

      expected_response = %{ein: "unknown error"}

      assert response == expected_response
    end
  end

  describe "when the value is not a string" do
    test "then return an error message" do
      response =
        %{ein: usa_ein(nil)}
        |> Elform.parse_errors()

      expected_response = %{ein: "the value must be a string"}

      assert response == expected_response
    end
  end

  describe "when the value is not a valid EIN" do
    test "then return an error message" do
      value = Faker.String.base64()

      response =
        %{ein: usa_ein(value)}
        |> Elform.parse_errors()

      expected_response = %{ein: "the value is not a valid EIN"}

      assert response == expected_response
    end
  end

  describe "when the value is a valid EIN" do
    test "then return ok" do
      value = "12-1234567"

      response =
        %{ein: usa_ein(value)}
        |> Elform.parse_errors()

      expected_response = %{ein: :ok}

      assert response == expected_response
    end
  end
end
