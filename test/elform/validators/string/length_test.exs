defmodule Elform.Validators.String.LengthTest do
  use ExUnit.Case

  describe "when the value matches the type" do
    test "should return a schema error" do
      schema = %{
        label: "email",
        required: true,
        validators: [length: {2, 4}]
      }

      payload = %{"email" => true}

      response = Elform.validate(schema, payload)

      assert %{"email" => [length: "the value should be a string"]} = response
    end
  end

  describe "when a value is required but has not been defined" do
    test "should return a schema error" do
      schema = %{
        label: "email",
        required: true,
        validators: [length: {2, 4}]
      }

      payload = %{}

      response = Elform.validate(schema, payload)

      assert %{"email" => [length: "the value is required"]} = response
    end
  end

  describe "when there are arguments in the validator" do
    test "should return a schema error" do
      schema = %{
        label: "email",
        required: true,
        validators: [length: {true, false}]
      }

      payload = %{"email" => "abcde"}

      response = Elform.validate(schema, payload)

      assert %{"email" => [length: "arguments should be a tuple with two numbers"]} = response
    end
  end

  describe "when the value is less than 2" do
    test "should return a schema error" do
      schema = %{
        label: "email",
        required: true,
        validators: [length: {2, 4}]
      }

      payload = %{"email" => "a"}

      response = Elform.validate(schema, payload)

      assert %{"email" => [length: "the value should be greater than or equal to 2"]} = response
    end
  end

  describe "when the value is greater than 4" do
    test "should return a schema error" do
      schema = %{
        label: "email",
        required: true,
        validators: [length: {2, 4}]
      }

      payload = %{"email" => "abcde"}

      response = Elform.validate(schema, payload)

      assert %{"email" => [length: "the value should be less than or equal to 4"]} = response
    end
  end

  describe "when all arguments are valid" do
    test "should return ':ok'" do
      schema = %{
        label: "email",
        required: true,
        validators: [length: {1, 10}]
      }

      payload = %{"email" => "abcde"}

      response = Elform.validate(schema, payload)

      assert %{"email" => :ok} = response
    end
  end
end
