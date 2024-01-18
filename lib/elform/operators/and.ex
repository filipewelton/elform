defmodule Elform.Operators.And do
  alias Elform.Utilities.KeyList
  alias Elform.Executor

  def call(_value, validators) when not is_list(validators) do
    raise ArgumentError, "The 'validators' argument should be a key list"
  end

  def call(value, validators) do
    KeyList.check_keys!(validators)
    iterate(validators, value)
  end

  defp iterate(validators, value) when validators != [] do
    [head | tail] = validators

    case Executor.execute_validator(head, value) do
      :ok -> iterate(tail, value)
      error -> error
    end
  end

  defp iterate(_validators, _value), do: :ok
end
