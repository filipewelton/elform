defmodule Elform.Validations.Strings.Bra.Cep do
  alias Elform.SchemaFieldError

  def bra_cep(%SchemaFieldError{} = value), do: value

  def bra_cep(value) when not is_bitstring(value) do
    %SchemaFieldError{
      arguments: [value],
      reason: "the value must be a string",
      value: value
    }
  end

  def bra_cep(value) do
    regex = ~r/^(\d{5}\-\d{3})$/

    if Regex.match?(regex, value) do
      value
    else
      %SchemaFieldError{
        arguments: [value],
        reason: "the value is not a valid CEP",
        value: value
      }
    end
  end
end
