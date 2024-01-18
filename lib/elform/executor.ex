defmodule Elform.Executor do
  alias Elform.Utilities.KeyList

  @validators Application.compile_env!(:elform, :validators)

  def call(key_list, value) when key_list != [] do
    [head | tail] = key_list

    case execute_validator(head, value) do
      :ok -> call(tail, value)
      error -> error
    end
  end

  def call(_key_list, _value), do: :ok

  def call(key_list, value, errors) when key_list != [] do
    [head | tail] = key_list

    case execute_validator(head, value) do
      :ok ->
        call(tail, value, errors)

      new_error ->
        updated_errors = Enum.concat(errors, new_error)
        call(tail, value, updated_errors)
    end
  end

  def call(_key_list, _value, errors) when errors == [], do: :ok

  def call(_key_list, _value, errors), do: errors

  def execute_validator(validator, value) do
    if is_atom(validator) do
      {_key, module} = KeyList.fetch!(@validators, validator)
      module.call(value)
    else
      {func, args} = validator
      {_key, module} = KeyList.fetch!(@validators, func)
      module.call(value, args)
    end
  end
end
