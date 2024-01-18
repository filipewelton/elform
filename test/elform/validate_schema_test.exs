defmodule Elform.ValidateSchemaTest do
  use ExUnit.Case

  alias Elform.Schema

  describe "when 'stop_on_first_error' option is disabled" do
    test "should return two error clauses" do
      options = [stop_on_first_error: false]
      expected_text = Faker.Address.street_address()

      schema = %{
        label: "address",
        validators: [
          text_equality: expected_text,
          length_less_than: 2
        ]
      }

      payload = %{"address" => Faker.Address.street_address()}
      response = Elform.validate(schema, payload, options)

      expected_response = %{
        "address" => [
          text_equality: "text should be equal to '#{expected_text}'",
          length_less_than: "the text length should be less than 2"
        ]
      }

      assert response == expected_response
    end

    test "should return no error" do
      options = [stop_on_first_error: false]
      expected_text = Faker.Address.street_address()

      schema = %{
        label: "address",
        validators: [
          text_equality: expected_text,
          length_greater_than: 2
        ]
      }

      payload = %{"address" => expected_text}
      response = Elform.validate(schema, payload, options)
      expected_response = %{"address" => :ok}

      assert response == expected_response
    end
  end

  describe "when 'stop_on_first_error' option is enabled" do
    test "should return a schema error" do
      schema = %{label: "address"}
      payload = %{"address" => Faker.Address.street_address()}
      %Schema{errors: errors} = Elform.validate(schema, payload)
      expected_errors = [validators: "is missing"]

      assert errors == expected_errors
    end

    test "should return an error clause" do
      expected_text = Faker.Address.street_address()

      schema = %{
        label: "address",
        validators: [
          text_equality: expected_text,
          length_less_than: 2
        ]
      }

      payload = %{"address" => Faker.Address.street_address()}
      response = Elform.validate(schema, payload)

      expected_response = %{
        "address" => [text_equality: "text should be equal to '#{expected_text}'"]
      }

      assert response == expected_response
    end
  end

  describe "when 'custom_validators' option is not keyword list" do
    test "should return a tuple" do
      options = [custom_validators: %{}]

      schema = %{
        label: "address",
        validators: []
      }

      payload = %{"address" => Faker.Address.street_address()}

      assert_raise(ArgumentError, fn -> Elform.validate(schema, payload, options) end)
    end
  end

  describe "when 'custom_validators' option is invalid list" do
    test "should return a tuple" do
      options = [custom_validators: [:a, :b, :c]]

      schema = %{
        label: "address",
        validators: []
      }

      payload = %{"address" => Faker.Address.street_address()}

      assert_raise(ArgumentError, fn -> Elform.validate(schema, payload, options) end)
    end
  end

  describe "when 'custom_validators' option is valid" do
    test "should return a tuple" do
      options = [custom_validators: [fake: Faker]]

      schema = %{
        label: "address",
        validators: []
      }

      payload = %{"address" => Faker.Address.street_address()}
      response = Elform.validate(schema, payload, options)
      expected_response = %{"address" => :ok}

      assert response == expected_response
    end
  end
end
