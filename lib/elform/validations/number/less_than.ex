defmodule Elform.Validations.Number.LessThan do
  @behaviour Elform.Validations.Behaviour

  use Elform.Utilities.ActionFallback, name: :less_than, type: :number

  def call(value, args) do
    case value < args do
      true -> :ok
      false -> [less_than: "the value must be less than #{args}"]
    end
  end
end
