defmodule Elform.Validations.Strings.CreditCard do
  alias Elform.SchemaFieldError

  def credit_card(%SchemaFieldError{} = value), do: value

  def credit_card(value) when not is_bitstring(value) do
    %SchemaFieldError{
      arguments: [value],
      reason: "the value must be a string",
      value: value
    }
  end

  def credit_card(value) do
    regex =
      ~r/^(?:4[0-9]{12}(?:[0-9]{3})?|[25][1-7][0-9]{14}|6(?:011|5[0-9][0-9])[0-9]{12}|3[47][0-9]{13}|3(?:0[0-5]|[68][0-9])[0-9]{11}|(?:2131|1800|35\d{3})\d{11})$/

    if Regex.match?(regex, value) do
      value
    else
      %SchemaFieldError{
        arguments: [value],
        reason: "the value is not a valid credit card number",
        value: value
      }
    end
  end
end
