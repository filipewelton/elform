defmodule Elform.Validators.Number.GreaterThan do
  @behaviour Elform.Validators.Behaviour

  use Elform.Utilities.ValidatorActionFallback, name: :greater_than, type: :number

  def call(value, args) do
    case value > args do
      true -> :ok
      false -> [greater_than: "the value should be greater than #{args}"]
    end
  end
end
