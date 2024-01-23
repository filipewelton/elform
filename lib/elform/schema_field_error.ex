defmodule Elform.SchemaFieldError do
  @keys [:arguments, :reason, :value]
  @enforce_keys @keys

  defstruct @keys
end
