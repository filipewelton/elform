defmodule Elform.Validations.Strings.LengthTest do
  use ExUnit.Case
  use Elform

  alias Elform.SchemaFieldError

  @min :rand.uniform(9)
  @max @min + :rand.uniform(19) + 1

  describe "when the first argument is a SchemaFieldError" do
    test "then return an error message" do
      error = %SchemaFieldError{
        arguments: [],
        reason: "unknown error",
        value: nil
      }

      response =
        %{field: length(error, @min, @max)}
        |> Elform.parse_errors()

      expected_response = %{field: "unknown error"}

      assert response == expected_response
    end
  end

  describe "when the first argument is not a string" do
    test "then return an error message" do
      value = nil

      response =
        %{field: length(value, @min, @max)}
        |> Elform.parse_errors()

      expected_response = %{field: "the value must be a string"}

      assert response == expected_response
    end
  end

  describe "when the second argument is not a number" do
    test "then return an error message" do
      value = Faker.String.base64(@min)

      response =
        %{field: length(value, nil, @max)}
        |> Elform.parse_errors()

      expected_response = %{field: "the function has one or more invalid arguments"}

      assert response == expected_response
    end
  end

  describe "when the third argument is not a number" do
    test "then return an error message" do
      value = Faker.String.base64(@min)

      response =
        %{field: length(value, @min, nil)}
        |> Elform.parse_errors()

      expected_response = %{field: "the function has one or more invalid arguments"}

      assert response == expected_response
    end
  end

  describe "when the text length is less than allowed" do
    test "then return an error message" do
      value = Faker.String.base64(@min - 1)

      response =
        %{field: length(value, @min, @max)}
        |> Elform.parse_errors()

      expected_response = %{
        field: "the value must be greater than #{@min} and less than #{@max}"
      }

      assert response == expected_response
    end
  end

  describe "when the text length is greater than allowed" do
    test "then return an error message" do
      value = Faker.String.base64(@max + 1)

      response =
        %{field: length(value, @min, @max)}
        |> Elform.parse_errors()

      expected_response = %{
        field: "the value must be greater than #{@min} and less than #{@max}"
      }

      assert response == expected_response
    end
  end

  describe "when text length is greater than #{@min}" do
    test "then return ok" do
      value = Faker.String.base64(@min + 1)

      response =
        %{field: length(value, @min, @max)}
        |> Elform.parse_errors()

      expected_response = %{field: :ok}

      assert response == expected_response
    end
  end
end
