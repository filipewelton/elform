defmodule Elform.Validators.String.MatchPatternTest do
  use ExUnit.Case

  describe "when passing a pattern as string" do
    test "should return a schema error" do
      email = Faker.Internet.email()

      schema = %{
        label: "email",
        validators: [match_pattern: "^(\d+)$"]
      }

      payload = %{"email" => email}
      response = Elform.validate(schema, payload)

      expected_response = %{
        "email" => [match_pattern: "argument should be a regex"]
      }

      assert response == expected_response
    end
  end

  describe "when the value does not match with pattern" do
    test "should return a schema error" do
      email = Faker.Internet.email()

      schema = %{
        label: "email",
        validators: [match_pattern: ~r/^(\d+)$/]
      }

      payload = %{"email" => email}
      response = Elform.validate(schema, payload)

      expected_response = %{
        "email" => [match_pattern: "the value does not match the pattern"]
      }

      assert response == expected_response
    end
  end

  describe "when the value does match with pattern" do
    test "should return ':ok'" do
      email = Faker.Internet.email()

      schema = %{
        label: "email",
        validators: [match_pattern: ~r/^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/]
      }

      payload = %{"email" => email}
      response = Elform.validate(schema, payload)
      expected_response = %{"email" => :ok}

      assert response == expected_response
    end
  end
end
