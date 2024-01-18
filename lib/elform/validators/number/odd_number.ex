defmodule Elform.Validators.Number.OddNumber do
  @behaviour Elform.Validators.Behaviour

  use Elform.Utilities.ValidatorActionFallback, name: :odd_number, type: :number

  require Integer

  def call(value) do
    case Integer.is_odd(value) do
      true -> :ok
      false -> [odd_number: "the value should be an odd number"]
    end
  end
end
