defmodule Elform.Validations.Generics.EqualTest do
  use ExUnit.Case
  use Elform

  alias Elform.SchemaFieldError

  @text Faker.Lorem.word()
  @number :rand.uniform()
  @map %{
    email: Faker.Internet.email(),
    password: Faker.Lorem.sentence(10)
  }
  @list [
    Faker.Lorem.word(),
    Faker.Lorem.word(),
    Faker.Lorem.word()
  ]

  describe "when the first argument is a SchemaFieldError" do
    test "then return a SchemaFieldError" do
      error = %SchemaFieldError{
        arguments: [],
        reason: "unknown error",
        value: nil
      }

      response =
        %{email: equal(error, nil)}
        |> Elform.parse_errors()

      expected_response = %{email: "unknown error"}

      assert response == expected_response
    end
  end

  describe "when the value should be of type string" do
    test "then return a SchemaFieldError" do
      response =
        %{
          field: equal(1, Faker.Lorem.word())
        }
        |> Elform.parse_errors()

      expected_response = %{field: "the value must be a string"}

      assert response == expected_response
    end
  end

  describe "when the value should be of type number" do
    test "then return a SchemaFieldError" do
      response =
        %{
          field: equal(Faker.Lorem.word(), :rand.uniform())
        }
        |> Elform.parse_errors()

      expected_response = %{field: "the value must be a number"}

      assert response == expected_response
    end
  end

  describe "when the value should be of type list" do
    test "then return a SchemaFieldError" do
      response =
        %{
          field: equal(1, [])
        }
        |> Elform.parse_errors()

      expected_response = %{field: "the value must be a list"}

      assert response == expected_response
    end
  end

  describe "when the value should be of type map" do
    test "then return a SchemaFieldError" do
      response =
        %{
          field: equal(1, %{})
        }
        |> Elform.parse_errors()

      expected_response = %{field: "the value must be a map"}

      assert response == expected_response
    end
  end

  describe "when the argument type is not allowed" do
    test "then return a SchemaFieldError" do
      response =
        %{
          field: equal(1, true)
        }
        |> Elform.parse_errors()

      expected_response = %{field: "the function has an invalid argument"}

      assert response == expected_response
    end
  end

  describe "when the value is of type string and is equal to expected" do
    test "then return ok" do
      response =
        %{
          field: equal(@text, @text)
        }
        |> Elform.parse_errors()

      expected_response = %{field: :ok}

      assert response == expected_response
    end
  end

  describe "when the value is of type string and is different from expected" do
    test "then return a SchemaFieldError" do
      response =
        %{
          field: equal(Faker.Lorem.word(), @text)
        }
        |> Elform.parse_errors()

      expected_response = %{field: "the value must be equal to #{@text}"}

      assert response == expected_response
    end
  end

  describe "when the value is of numeric type and is equal to expected" do
    test "then return ok" do
      response =
        %{field: equal(@number, @number)}
        |> Elform.parse_errors()

      expected_response = %{field: :ok}

      assert response == expected_response
    end
  end

  describe "when the value is of numeric type and is different from expected" do
    test "then return a SchemaFieldError" do
      response =
        %{field: equal(:rand.uniform(), @number)}
        |> Elform.parse_errors()

      expected_response = %{field: "the value must be equal to #{@number}"}

      assert response == expected_response
    end
  end

  describe "when the value of type map and is equal to expected" do
    test "then return ok" do
      response =
        %{field: equal(@map, @map)}
        |> Elform.parse_errors()

      expected_response = %{field: :ok}

      assert response == expected_response
    end
  end

  describe "when the value of type map and is different from expected" do
    test "then return a SchemaFieldError" do
      response =
        %{field: equal(%{}, @map)}
        |> Elform.parse_errors()

      expected_response = %{field: "the value must be the same as expected"}

      assert response == expected_response
    end
  end

  describe "when the value of type list and is equal to expected" do
    test "then return ok" do
      response =
        %{field: equal(@list, @list)}
        |> Elform.parse_errors()

      expected_response = %{field: :ok}

      assert response == expected_response
    end
  end

  describe "when the value of type list and is different from expected" do
    test "then return a SchemaFieldError" do
      response =
        %{field: equal([], @list)}
        |> Elform.parse_errors()

      expected_response = %{field: "the value must be the same as expected"}

      assert response == expected_response
    end
  end
end
