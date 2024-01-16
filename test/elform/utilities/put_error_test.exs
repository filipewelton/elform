defmodule Elform.Utilities.PutErrorTest do
  use ExUnit.Case

  alias Elform.Schema
  alias Elform.Utilities.PutError

  describe "call/2" do
    test "when all arguments is valid" do
      schema = %Schema{
        errors: [],
        label: "something",
        required: true,
        valid?: true,
        validators: [],
      }
      %Schema{errors: errors} = PutError.call(schema, error: "unknown")
      expected_error = [error: "unknown"]
      assert errors == expected_error
    end
  end
end
