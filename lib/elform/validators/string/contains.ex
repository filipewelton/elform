defmodule Elform.Validators.String.Contains do
  @behaviour Elform.Validators.Behaviour

  use Elform.Utilities.ValidatorActionFallback, name: :contains, type: :string

  def call(value, args) do
    case String.contains?(value, args) do
      true -> :ok
      false -> [contains: "the value does not contains #{args}"]
    end
  end
end
