defmodule Elform.Validations.Number.GreaterThan do
  @behaviour Elform.Validations.Behaviour

  use Elform.Utilities.ActionFallback, name: :greater_than, type: :number

  def call(value, args) do
    case value > args do
      true -> :ok
      false -> [greater_than: "the value must be greater than #{args}"]
    end
  end
end
