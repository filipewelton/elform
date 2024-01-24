defmodule Elform.Validations.Strings.MatchesTest do
  use ExUnit.Case
  use Elform

  alias Elform.SchemaFieldError

  describe "when the first argument is a SchemaFieldError" do
    test "then return a SchemaFieldError" do
      error = %SchemaFieldError{
        arguments: [],
        reason: "unknown error",
        value: nil
      }

      response =
        %{field: matches(error, ~r//)}
        |> Elform.parse_errors()

      expected_response = %{field: "unknown error"}

      assert response == expected_response
    end
  end

  describe "when the first argument is not a string" do
    test "then return a SchemaFieldError" do
      response =
        %{field: matches(nil, ~r//)}
        |> Elform.parse_errors()

      expected_response = %{field: "the value must be a string"}

      assert response == expected_response
    end
  end

  describe "when the second argument is not a regex" do
    test "then return a SchemaFieldError" do
      value = Faker.String.base64()

      response =
        %{field: matches(value, nil)}
        |> Elform.parse_errors()

      expected_response = %{field: "the function has an invalid argument"}

      assert response == expected_response
    end
  end

  describe "when the value does not match the pattern" do
    test "then return a SchemaFieldError" do
      value = Faker.Lorem.word()
      regex = ~r/^([0-9]+)$/
      source = Regex.source(regex)

      response =
        %{field: matches(value, regex)}
        |> Elform.parse_errors()

      expected_response = %{field: "the vale must match the pattern #{source}"}

      assert response == expected_response
    end
  end

  describe "when the value matches the pattern" do
    test "then return ok" do
      value = Faker.Lorem.word()
      regex = ~r/^([a-zA-Z]+)$/

      response =
        %{field: matches(value, regex)}
        |> Elform.parse_errors()

      expected_response = %{field: :ok}

      assert response == expected_response
    end
  end
end
