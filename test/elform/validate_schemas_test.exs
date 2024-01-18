defmodule Elform.ValidateSchemasTest do
  use ExUnit.Case

  describe "when the 'custom_validators' option is invalid" do
    test "should throw argument error" do
      schema = [
        %{
          label: "email",
          validators: []
        }
      ]

      payload = %{"email" => Faker.Internet.email()}
      options = [custom_validators: [:a, :b, :c]]

      assert_raise(ArgumentError, fn -> Elform.validate(schema, payload, options) end)
    end
  end

  describe "when all schemas is valid" do
    test "should return ':ok' for each schema" do
      email = Faker.Internet.email()
      password = Faker.String.base64()

      schemas = [
        %{
          label: "email",
          validators: [text_equality: email]
        },
        %{
          label: "password",
          validators: [text_equality: password]
        }
      ]

      payload = %{
        "email" => email,
        "password" => password
      }

      response = Elform.validate(schemas, payload)

      expected_response = %{
        "email" => :ok,
        "password" => :ok
      }

      assert response == expected_response
    end
  end

  describe "when one of the schemas is invalid" do
    test "should return error due to invalid password" do
      email = Faker.Internet.email()
      password = Faker.String.base64()

      schemas = [
        %{
          label: "email",
          validators: [text_equality: email]
        },
        %{
          label: "password",
          validators: [text_equality: password]
        }
      ]

      payload = %{
        "email" => email,
        "password" => Faker.String.base64()
      }

      response = Elform.validate(schemas, payload)

      expected_response = %{
        "email" => :ok,
        "password" => [text_equality: "text should be equal to '#{password}'"]
      }

      assert response == expected_response
    end
  end
end
