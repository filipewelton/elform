defmodule Elform.Validations.Strings.EmailTest do
  use ExUnit.Case
  use Elform

  alias Elform.SchemaFieldError

  describe "when the value is a SchemaFieldError" do
    test "then return a SchemaFieldError" do
      error = %SchemaFieldError{
        arguments: [],
        reason: "unknown error",
        value: nil
      }

      response =
        %{email: email(error)}
        |> Elform.parse_errors()

      expected_response = %{email: "unknown error"}

      assert response == expected_response
    end
  end

  describe "when the value is not a string" do
    test "then return a SchemaFieldError" do
      response =
        %{email: email(nil)}
        |> Elform.parse_errors()

      expected_response = %{email: "the value must be a string"}

      assert response == expected_response
    end
  end

  describe "when the value does not matches with the pattern" do
    test "then return a SchemaFieldError" do
      value = Faker.String.base64()

      response =
        %{email: email(value)}
        |> Elform.parse_errors()

      expected_response = %{email: "the value is not a valid email"}

      assert response == expected_response
    end
  end

  describe "when the value matches with the pattern" do
    test "then return ok" do
      value = Faker.Internet.email()

      response =
        %{email: email(value)}
        |> Elform.parse_errors()

      expected_response = %{email: :ok}

      assert response == expected_response
    end
  end
end
