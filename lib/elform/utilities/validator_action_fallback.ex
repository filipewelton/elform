defmodule Elform.Utilities.ValidatorActionFallback do
  defmacro __using__(opts) do
    name = opts[:name]
    type = opts[:type]

    if name == nil or type == nil do
      quote do
        def call(_, _) do
          {:error, "The action fallback should receive name and type arguments"}
        end
      end
    else
      quote do
        def call(:undefined, _args) do
          [{unquote(name), "the value is required"}]
        end

        cond do
          unquote(type) == :string ->
            def call(value, _arg) when not is_bitstring(value) do
              [{unquote(name), "the value should be a string"}]
            end

          unquote(type) == :number ->
            def call(value, _arg) when not is_number(value) do
              [{unquote(name), "the value should be a number"}]
            end

            def call(value) when not is_number(value) do
              [{unquote(name), "the value should be a number"}]
            end

          unquote(type) == :boolean ->
            def call(value, _arg) when not is_boolean(value) do
              [{unquote(name), "the value should be a boolean"}]
            end

          unquote(type) == :list ->
            def call(value, _arg) when not is_list(value) do
              [{unquote(name), "the value should be a list"}]
            end

          unquote(type) == :map ->
            def call(value, _arg) when not is_map(value) do
              [{unquote(name), "the value should be a map"}]
            end

          true ->
            :ok
        end
      end
    end
  end
end
