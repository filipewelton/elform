defmodule Elform.Validators.Number.EvenNumber do
  @behaviour Elform.Validators.Behaviour

  use Elform.Utilities.ValidatorActionFallback, name: :even_number, type: :number

  require Integer

  def call(value) do
    case Integer.is_even(value) do
      true -> :ok
      false -> [even_number: "the value should be an even number"]
    end
  end
end
