defmodule Elform.Validations.Numbers.OddNumber do
  alias Elform.SchemaFieldError

  require Integer

  def odd_number(%SchemaFieldError{} = value), do: value

  def odd_number(value) when not is_number(value) do
    %SchemaFieldError{
      arguments: [],
      reason: "the value must be a number",
      value: value
    }
  end

  def odd_number(value) do
    if Integer.is_odd(value) do
      value
    else
      %SchemaFieldError{
        arguments: [],
        reason: "the value must be a odd number",
        value: value
      }
    end
  end
end
