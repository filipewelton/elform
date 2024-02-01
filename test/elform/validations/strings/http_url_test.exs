defmodule Elform.Validations.Strings.UrlTest do
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
        %{url: http_url(error)}
        |> Elform.parse_errors()

      expected_response = %{url: "unknown error"}

      assert response == expected_response
    end
  end

  describe "when the value is not a string" do
    test "then return an error message" do
      response =
        %{url: http_url(nil)}
        |> Elform.parse_errors()

      expected_response = %{url: "the value must be a string"}

      assert response == expected_response
    end
  end

  describe "when the value is not a valid URL" do
    test "then return an error message" do
      value = Faker.String.base64()

      response =
        %{url: http_url(value)}
        |> Elform.parse_errors()

      expected_response = %{url: "the value is not a valid URL"}

      assert response == expected_response
    end
  end

  describe "when the value is a valid URL" do
    test "then return ok" do
      value = Faker.Internet.url()

      response =
        %{url: http_url(value)}
        |> Elform.parse_errors()

      expected_response = %{url: :ok}

      assert response == expected_response
    end
  end
end
