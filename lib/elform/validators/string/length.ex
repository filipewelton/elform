defmodule Elform.Validators.String.Length do
  @behaviour Elform.Validators.Behaviour

  use Elform.Utilities.ValidatorActionFallback, name: :length, type: :string

  def call(_value, {min, max}) when not is_integer(min) or not is_integer(max) do
    [length: "arguments should be a tuple with two numbers"]
  end

  def call(value, {min, max}) do
    l = String.length(value)

    cond do
      l < min -> [length: "the value should be greater than or equal to #{min}"]
      l > max -> [length: "the value should be less than or equal to #{max}"]
      true -> :ok
    end
  end
end
