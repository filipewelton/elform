defmodule Elform.Operators.Or do
  alias Elform.Executor
  alias Elform.Utilities.KeyList

  def call(_value, validators) when not is_list(validators) do
    raise ArgumentError, "The 'validators' argument should be a key list"
  end

  def call(value, validators) do
    KeyList.check_keys!(validators)
    results = Enum.map(validators, &Executor.execute_validator(&1, value))

    if :ok in results do
      :ok
    else
      errors = Enum.uniq(results)
      |> List.delete(:ok)
      |> List.flatten()
      |> Keyword.values()

      [or: errors]
    end
  end
end
