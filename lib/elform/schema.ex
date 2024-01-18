defmodule Elform.Schema do
  alias Elform.Utilities.KeyList
  alias Elform.Utilities.PutError

  @keys [:label, :required, :validators, :valid?, :errors]
  @enforce_keys @keys

  defstruct @keys

  def cast(params) do
    schema = %__MODULE__{
      label: nil,
      required: false,
      validators: nil,
      valid?: true,
      errors: []
    }

    check_label(schema, params)
    |> check_required(params)
    |> check_validators(params)
    |> Map.put(:label, params[:label])
    |> Map.put(:type, params[:type])
    |> Map.put(:required, params[:required] || false)
    |> Map.put(:validators, params[:validators] || [])
  end

  defp check_label(schema, params) do
    cond do
      not Map.has_key?(params, :label) ->
        PutError.call(schema, label: "is missing")

      not is_bitstring(params[:label]) ->
        PutError.call(schema, label: "should be a string")

      true ->
        schema
    end
  end

  defp check_required(%__MODULE__{valid?: false} = schema, _params), do: schema

  defp check_required(schema, params) do
    if Map.has_key?(params, :required) and not is_boolean(params[:required]) do
      PutError.call(schema, required: "should be a boolean")
    else
      schema
    end
  end

  defp check_validators(%__MODULE__{valid?: false} = schema, _params), do: schema

  defp check_validators(schema, params) do
    cond do
      not Map.has_key?(params, :validators) ->
        PutError.call(schema, validators: "is missing")

      handle_key_checking(params) ->
        PutError.call(schema, validators: "should be a key list")

      true ->
        schema
    end
  end

  defp handle_key_checking(%{validators: validators}) do
    KeyList.check_keys!(validators)
    false
  rescue
    _error in ArgumentError -> true
  end
end
