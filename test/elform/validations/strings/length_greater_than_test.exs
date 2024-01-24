defmodule Elform.Validations.Strings.LengthGreaterThanTest do
  use ExUnit.Case
  use Elform

  alias Elform.SchemaFieldError

  @required_length :rand.uniform(9)

  describe "when the first argument is a SchemaFieldError" do
    test "then return an error message" do
      error = %SchemaFieldError{
        arguments: [],
        reason: "unknown error",
        value: nil
      }

      response =
        %{field: length_greater_than(error, @required_length)}
        |> Elform.parse_errors()

      expected_response = %{field: "unknown error"}

      assert response == expected_response
    end
  end

  describe "when the second argument is not a number" do
    test "then return an error message" do
      value = Faker.String.base64(@required_length)

      response =
        %{field: length_greater_than(value, nil)}
        |> Elform.parse_errors()

      expected_response = %{field: "the function has an invalid argument"}

      assert response == expected_response
    end
  end

  describe "when the first argument is not a string" do
    test "then return an error message" do
      value = nil

      response =
        %{field: length_greater_than(value, @required_length)}
        |> Elform.parse_errors()

      expected_response = %{field: "the value must be a string"}

      assert response == expected_response
    end
  end

  describe "when the text length is less than #{@required_length}" do
    test "then return an error message" do
      value = Faker.String.base64(@required_length)

      response =
        %{field: length_greater_than(value, @required_length)}
        |> Elform.parse_errors()

      expected_response = %{field: "the value must be greater than #{@required_length}"}

      assert response == expected_response
    end
  end

  describe "when the text length is greater than #{@required_length}" do
    test "then return ok" do
      value = Faker.String.base64(@required_length + 1)

      response =
        %{field: length_greater_than(value, @required_length)}
        |> Elform.parse_errors()

      expected_response = %{field: :ok}

      assert response == expected_response
    end
  end
end
