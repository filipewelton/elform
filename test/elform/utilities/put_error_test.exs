defmodule Elform.Utilities.PutErrorTest do
  use ExUnit.Case

  alias Elform.Schema
  alias Elform.Utilities.PutError

  describe "when all arguments is valid" do
    test "should return unknown error" do
      %Schema{errors: errors} = Schema.cast(%{
        label: "email",
        validators: []
      })
      |> PutError.call(error: "unknown")

      expected_errors = [error: "unknown"]

      assert errors == expected_errors
    end
  end
end
