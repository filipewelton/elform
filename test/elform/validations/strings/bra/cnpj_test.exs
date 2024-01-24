defmodule Elform.Validations.Strings.Bra.CnpjTest do
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
        %{cnpj: bra_cnpj(error)}
        |> Elform.parse_errors()

      expected_response = %{cnpj: "unknown error"}

      assert response == expected_response
    end
  end

  describe "when the value is not a string" do
    test "then return an error message" do
      response =
        %{cnpj: bra_cnpj(nil)}
        |> Elform.parse_errors()

      expected_response = %{cnpj: "the value must be a string"}

      assert response == expected_response
    end
  end

  describe "when the value is not a valid CNPJ" do
    test "then return an error message" do
      value = Faker.String.base64()

      response =
        %{cnpj: bra_cnpj(value)}
        |> Elform.parse_errors()

      expected_response = %{cnpj: "the value is not a valid CNPJ"}

      assert response == expected_response
    end
  end

  describe "when the value is a valid CNPJ" do
    test "then return ok" do
      value = "66.494.705/0001-10"

      response =
        %{cnpj: bra_cnpj(value)}
        |> Elform.parse_errors()

      expected_response = %{cnpj: :ok}

      assert response == expected_response
    end
  end
end
