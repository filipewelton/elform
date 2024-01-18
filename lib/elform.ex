defmodule Elform do
  alias Elform.Executor
  alias Elform.Schema

  def validate(schema, payload, options \\ [])

  def validate(schema, payload, options) when is_map(schema) and is_map(payload) do
    stop_on_first_error = Keyword.get(options, :stop_on_first_error, true)
    custom_validators = Keyword.get(options, :custom_validators, [])

    with :ok <- check_custom_validators(custom_validators),
         :ok <- merge_validator_list(custom_validators),
         {:ok, parsed_schema} <- handle_cast_schema(schema) do
      %Schema{label: label, validators: validators} = parsed_schema
      value = Map.get(payload, label, :undefined)

      reply =
        if stop_on_first_error do
          Executor.call(validators, value)
        else
          Executor.call(validators, value, [])
        end

      %{label => reply}
    end
  end

  def validate(schemas, payload, options) when is_list(schemas) and is_map(payload) do
    handle_recursive_validation(schemas, payload, options, [])
  end

  defp handle_recursive_validation(schemas, payload, options, results)
       when schemas != [] do
    [head | tail] = schemas
    result = validate(head, payload, options)
    updated_results = results ++ [result]

    handle_recursive_validation(tail, payload, options, updated_results)
  end

  defp handle_recursive_validation(_schemas, _payload, _options, results) do
    Enum.reduce(results, %{}, &Map.merge(&2, &1))
  end

  defp check_custom_validators(custom_validators) when not is_list(custom_validators) do
    raise ArgumentError, "The 'custom_validators' option should be a keyword list"
  end

  defp check_custom_validators(custom_validators) do
    case Enum.any?(custom_validators, &(not is_tuple(&1))) do
      false ->
        :ok

      true ->
        raise ArgumentError, "The 'custom_validators' option should be a keyword list"
    end
  end

  defp merge_validator_list(custom_validators) when custom_validators == [], do: :ok

  defp merge_validator_list(custom_validators) do
    default = Application.fetch_env!(:elform, :validators)
    updated = List.flatten(default, custom_validators)
    Application.put_env(:elform, :validators, updated)

    :ok
  end

  defp handle_cast_schema(schema) do
    case Schema.cast(schema) do
      %Schema{valid?: true} = parsed_schema -> {:ok, parsed_schema}
      cast -> cast
    end
  end
end
