defmodule Elform.Validations.Strings.Matches do
  alias Elform.SchemaFieldError

  def matches(%SchemaFieldError{} = value, _regex), do: value

  def matches(value, regex) when not is_bitstring(value) do
    %SchemaFieldError{
      arguments: [regex],
      reason: "the value must be a string",
      value: value
    }
  end

  def matches(value, regex) do
    if Regex.match?(regex, value) do
      value
    else
      source = Regex.source(regex)

      %SchemaFieldError{
        arguments: [regex],
        reason: "the vale must match the pattern #{source}",
        value: value
      }
    end
  rescue
    _error in FunctionClauseError ->
      %SchemaFieldError{
        arguments: [regex],
        reason: "the function has an invalid argument",
        value: value
      }
  end
end
