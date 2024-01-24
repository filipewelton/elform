defmodule Elform.Validations.Strings.Bra.CpfTest do
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
        %{cpf: bra_cpf(error)}
        |> Elform.parse_errors()

      expected_response = %{cpf: "unknown error"}

      assert response == expected_response
    end
  end

  describe "when the value is not a string" do
    test "then return an error message" do
      response =
        %{cpf: bra_cpf(nil)}
        |> Elform.parse_errors()

      expected_response = %{cpf: "the value must be a string"}

      assert response == expected_response
    end
  end

  describe "when the value is not a valid CPF" do
    test "then return an error message" do
      value = Faker.String.base64()

      response =
        %{cpf: bra_cpf(value)}
        |> Elform.parse_errors()

      expected_response = %{cpf: "the value is not a valid CPF"}

      assert response == expected_response
    end
  end

  describe "when the value is a valid CPF" do
    test "then return ok" do
      value = "049.157.930-60"

      response =
        %{cpf: bra_cpf(value)}
        |> Elform.parse_errors()

      expected_response = %{cpf: :ok}

      assert response == expected_response
    end
  end
end
