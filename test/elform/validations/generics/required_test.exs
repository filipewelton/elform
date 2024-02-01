defmodule Elform.Validations.Generics.RequiredTest do
  use ExUnit.Case
  use Elform

  alias Elform.SchemaFieldError

  describe "when the value is a SchemaFieldError" do
    test "then return an error message" do
      value = %SchemaFieldError{arguments: [], reason: "unknown error", value: nil}

      response =
        %{field: required(value)}
        |> Elform.parse_errors()

      expected_response = %{field: "unknown error"}

      assert response == expected_response
    end
  end

  describe "when the value is nil" do
    test "then return an error message" do
      response =
        %{field: required(nil)}
        |> Elform.parse_errors()

      expected_response = %{field: "a value is required"}

      assert response == expected_response
    end
  end

  describe "when the value is not nil" do
    test "then return an error message" do
      response =
        %{field: required([])}
        |> Elform.parse_errors()

      expected_response = %{field: :ok}

      assert response == expected_response
    end
  end
end
