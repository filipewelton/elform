defmodule Elform.Validations.Strings.HttpUrl do
  alias Elform.SchemaFieldError

  def http_url(%SchemaFieldError{} = value), do: value

  def http_url(value) when not is_bitstring(value) do
    %SchemaFieldError{
      arguments: [],
      reason: "the value must be a string",
      value: value
    }
  end

  def http_url(value) do
    regex =
      ~r/^https?:\/\/(?:www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b(?:[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)$/

    if Regex.match?(regex, value) do
      value
    else
      %SchemaFieldError{
        arguments: [],
        reason: "the value is not a valid URL",
        value: value
      }
    end
  end
end
