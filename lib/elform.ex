defmodule Elform do
  alias Elform.SchemaFieldError

  defmacro __using__(_opts) do
    quote do
      import Elform.Validations.Generics.Equal
      import Elform.Validations.Strings.Bra.Cep
      import Elform.Validations.Strings.Bra.Cnpj
      import Elform.Validations.Strings.Bra.Cpf
      import Elform.Validations.Strings.CreditCard
      import Elform.Validations.Strings.Email
      import Elform.Validations.Strings.Length
      import Elform.Validations.Strings.LengthGreaterThan
      import Elform.Validations.Strings.LengthLessThan
      import Elform.Validations.Strings.Matches
    end
  end

  def parse_errors(term) when is_map(term) do
    Map.to_list(term)
    |> Enum.map(fn {key, value} ->
      case get_error(value) do
        nil -> {key, :ok}
        reason -> {key, reason}
      end
    end)
    |> Enum.reduce(%{}, fn {key, value}, acc -> Map.put(acc, key, value) end)
  end

  defp get_error(%SchemaFieldError{reason: reason}), do: reason

  defp get_error(_), do: nil
end
