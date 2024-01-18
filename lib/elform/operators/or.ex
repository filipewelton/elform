defmodule Elform.Operators.Or do
  alias Elform.Utilities.KeyList
  alias Elform.Executor

  def call(_value, validators) when not is_list(validators) do
    raise ArgumentError, "The 'validators' argument should be a key list"
  end

  def call(value, validators) do
    KeyList.check_keys!(validators)
    results = Enum.map(validators, &Executor.execute_validator(&1, value))

    if :ok in results, do: :ok, else: List.flatten(results)
  end
end
