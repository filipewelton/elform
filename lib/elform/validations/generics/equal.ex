defmodule Elform.Validations.Generics.Equal do
  alias Elform.SchemaFieldError

  def equal(%SchemaFieldError{} = value, _target), do: value

  def equal(value, target) when not is_bitstring(value) and is_bitstring(target) do
    %SchemaFieldError{
      arguments: [target],
      reason: "the value must be a string",
      value: value
    }
  end

  def equal(value, target) when not is_number(value) and is_number(target) do
    %SchemaFieldError{
      arguments: [target],
      reason: "the value must be a number",
      value: value
    }
  end

  def equal(value, target) when not is_list(value) and is_list(target) do
    %SchemaFieldError{
      arguments: [target],
      reason: "the value must be a list",
      value: value
    }
  end

  def equal(value, target) when not is_map(value) and is_map(target) do
    %SchemaFieldError{
      arguments: [target],
      reason: "the value must be a map",
      value: value
    }
  end

  def equal(value, target)
      when not is_bitstring(target) and
             not is_number(target) and
             not is_list(target) and
             not is_map(target) do
    %SchemaFieldError{
      arguments: [target],
      reason: "the function has an invalid argument",
      value: value
    }
  end

  def equal(value, target) do
    if value === target do
      value
    else
      reason =
        case is_map(target) or is_list(target) do
          true ->
            "the value must be the same as expected"

          false ->
            parsed_value = parse_to_string(target)
            "the value must be equal to #{parsed_value}"
        end

      %SchemaFieldError{
        arguments: [target],
        reason: reason,
        value: value
      }
    end
  end

  defp parse_to_string(term) when is_bitstring(term), do: term

  defp parse_to_string(term) when is_number(term), do: to_string(term)
end
