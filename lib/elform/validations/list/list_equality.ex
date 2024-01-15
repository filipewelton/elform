defmodule Elform.Validations.List.ListEquality do
  @behaviour Elform.Validations.Behaviour

  use Elform.Utilities.ActionFallback, name: :list_equality, type: :list

  def call(value, args) do
    l1 = Enum.sort(value) |> Enum.join(",")
    l2 = Enum.sort(args) |> Enum.join(",")

    case l1 === l2 do
      true -> :ok
      false -> [list_equality: "the list must be equal to [#{l2}]"]
    end
  end
end
