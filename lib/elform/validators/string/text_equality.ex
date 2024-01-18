defmodule Elform.Validators.String.TextEquality do
  @behaviour Elform.Validators.Behaviour

  use Elform.Utilities.ValidatorActionFallback, name: :text_equality, type: :string

  def call(value, args) do
    case value === args do
      true -> :ok
      false -> [text_equality: "text should be equal to '#{args}'"]
    end
  end
end
