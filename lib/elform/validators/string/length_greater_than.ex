defmodule Elform.Validators.String.LengthGreaterThan do
  @behaviour Elform.Validators.Behaviour

  use Elform.Utilities.ValidatorActionFallback, name: :length_greater_than, type: :string

  def call(value, args) do
    l = String.length(value)

    case l > args do
      true -> :ok
      false -> [length_greater_than: "the text length should be greater than #{args}"]
    end
  end
end
