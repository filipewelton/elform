defmodule Elform.Validators.String.LengthLessThan do
  @behaviour Elform.Validators.Behaviour

  use Elform.Utilities.ValidatorActionFallback, name: :length_less_than, type: :string

  def call(value, args) do
    l = String.length(value)

    case l < args do
      true -> :ok
      false -> [length_less_than: "the text length should be less than #{args}"]
    end
  end
end
