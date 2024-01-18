defmodule Elform.SchemaTest do
  use ExUnit.Case

  alias Elform.Schema

  describe "when 'label' property is missing" do
    test "should return an error: is missing" do
      %Schema{errors: errors} = Schema.cast(%{})
      expected_errors = [label: "is missing"]

      assert errors == expected_errors
    end
  end

  describe "when 'label' property does not string" do
    test "should return an error: should be a string" do
      %Schema{errors: errors} = Schema.cast(%{label: true})
      expected_errors = [label: "should be a string"]

      assert errors == expected_errors
    end
  end

  describe "when 'required' property does not boolean" do
    test "should return an error: should be a boolean" do
      %Schema{errors: errors} =
        Schema.cast(%{
          label: "something",
          required: 1
        })

      expected_errors = [required: "should be a boolean"]

      assert errors == expected_errors
    end
  end

  describe "when 'validators' property is missing" do
    test "should return an error: is missing" do
      %Schema{errors: errors} =
        Schema.cast(%{
          label: "something",
          required: true
        })

      expected_errors = [validators: "is missing"]

      assert errors == expected_errors
    end
  end

  describe "when 'validators' property does not a key list" do
    test "should return a error: should be a key list" do
      %Schema{errors: errors} =
        Schema.cast(%{
          label: "something",
          required: true,
          validators: %{}
        })

      expected_errors = [validators: "should be a key list"]

      assert errors == expected_errors
    end
  end

  describe "when 'validators' property has an invalid key" do
    test "should return an error: should be a key list" do
      %Schema{errors: errors} =
        Schema.cast(%{
          label: "something",
          required: true,
          validators: [invalid_key: true]
        })

      expected_errors = [validators: "should be a key list"]

      assert errors == expected_errors
    end
  end
end
