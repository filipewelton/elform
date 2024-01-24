# Elform
[![codecov](https://codecov.io/gh/filipewelton/elform/graph/badge.svg?token=8HSK2N9S8F)](https://codecov.io/gh/filipewelton/elform)

## Description
A simple and extensible data validator with functions capable of dealing with data such as strings, numbers, maps, and lists.

### It's Simple
Just call the validation functions and catch errors with the function 'parse_errors';

```elixir
# 1. Define the schema
schema = %{
  email: length_less_than("#{value}", 255) |> equal("#{expected}")
}

# 2. Parse errors
Elform.parse_errors(schema)
```

### It's Extensible
Just create and call custom functions since they follow the requirements.
- The function should be capable of dealing with the 'SchemaFieldError' struct;
- The function should be capable of dealing with the data type;
- The function can or cannot receive countless parameters;
- If the function receive parameters, they must be treated;
- If the value is invalid, it must be returned 'SchemaFieldError';

```elixir
defmodule CustomValidation do
  alias Elform.SchemaFieldError

  def custom(%SchemaFieldError{} = error), do: error

  def custom(%SchemaFieldError{} = error, args), do: error

  def custom(value), do: # something

  def custom(value, args), do: # something
end
```

## How To Use

```elixir
defmodule MyApp do
  use Elform # Use module

  def call(value, expected_value) do
    %{
      field_name: length(value, 1, 255) |> equal(expected_value)
    }
    |> Elform.parse_errors()
  end
end
```
