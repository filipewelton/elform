defmodule Elform.Validations.Strings.Bra.CepTest do
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
        %{cep: bra_cep(error)}
        |> Elform.parse_errors()

      expected_response = %{cep: "unknown error"}

      assert response == expected_response
    end
  end

  describe "when the value is not a string" do
    test "then return an error message" do
      response =
        %{cep: bra_cep(nil)}
        |> Elform.parse_errors()

      expected_response = %{cep: "the value must be a string"}

      assert response == expected_response
    end
  end

  describe "when the value is not a valid CEP" do
    test "then return an error message" do
      value = Faker.String.base64()

      response =
        %{cep: bra_cep(value)}
        |> Elform.parse_errors()

      expected_response = %{cep: "the value is not a valid CEP"}

      assert response == expected_response
    end
  end

  describe "when the value is a valid CEP" do
    test "then return ok" do
      value = "86810-160"

      response =
        %{cep: bra_cep(value)}
        |> Elform.parse_errors()

      expected_response = %{cep: :ok}

      assert response == expected_response
    end
  end
end
