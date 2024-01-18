defmodule Elform.Validators.Number.LessThan do
  @behaviour Elform.Validators.Behaviour

  use Elform.Utilities.ValidatorActionFallback, name: :less_than, type: :number

  def call(value, args) do
    case value < args do
      true -> :ok
      false -> [less_than: "the value should be less than #{args}"]
    end
  end
end
