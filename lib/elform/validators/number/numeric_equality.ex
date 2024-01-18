defmodule Elform.Validators.Number.NumericEquality do
  @behaviour Elform.Validators.Behaviour

  use Elform.Utilities.ValidatorActionFallback, name: :numeric_equality, type: :number

  def call(value, args) do
    case value === args do
      true -> :ok
      false -> [numeric_equality: "the value should be equal to #{args}"]
    end
  end
end
