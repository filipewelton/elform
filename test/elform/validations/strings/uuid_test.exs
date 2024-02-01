defmodule Elform.Validations.Strings.UuidTest do
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
        %{id: uuid(error)}
        |> Elform.parse_errors()

      expected_response = %{id: "unknown error"}

      assert response == expected_response
    end
  end

  describe "when the value is not a string" do
    test "then return an error message" do
      response =
        %{id: uuid(nil)}
        |> Elform.parse_errors()

      expected_response = %{id: "the value must be a string"}

      assert response == expected_response
    end
  end

  describe "when the value is not a valid UUID" do
    test "then return an error message" do
      value = Faker.String.base64()

      response =
        %{id: uuid(value)}
        |> Elform.parse_errors()

      expected_response = %{id: "the value is not a valid UUID"}

      assert response == expected_response
    end
  end

  describe "when the value is a valid UUID" do
    test "then return ok" do
      value = Faker.UUID.v4()

      response =
        %{id: uuid(value)}
        |> Elform.parse_errors()

      expected_response = %{id: :ok}

      assert response == expected_response
    end
  end
end
