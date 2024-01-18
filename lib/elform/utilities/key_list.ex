defmodule Elform.Utilities.KeyList do
  def check_keys!(list) do
    if key_list?(list) do
      validators = Application.fetch_env!(:elform, :validators)
      k = keys(validators)
      l = drop(list, k)

      case l === [] do
        true -> :ok
        false -> raise ArgumentError, "Argument has an invalid key(s)"
      end
    else
      raise ArgumentError, "Argument should be a keyword or atom list"
    end
  end

  defp key_list?(list) when list === [], do: true

  defp key_list?(list) when is_list(list) do
    not Enum.any?(list, fn e ->
      not is_atom(e) and not is_tuple(e)
    end)
  end

  defp key_list?(_), do: false

  def keys(list) when list == [], do: []

  def keys(list) do
    Enum.map(list, fn e ->
      if is_atom(e) do
        e
      else
        {key, _value} = e
        key
      end
    end)
  end

  def drop(list, _keys) when list == [], do: []

  def drop(list, keys) do
    keys(list)
    |> Enum.filter(&(&1 not in keys))
  end

  def fetch!(list, _key) when list == [], do: raise(KeyError, "Not found key")

  def fetch!(list, key) do
    result =
      Enum.filter(list, fn e ->
        cond do
          is_atom(e) ->
            e === key

          is_tuple(e) ->
            {k, _v} = e
            k === key
        end
      end)
      |> List.first()

    if result == nil, do: raise(KeyError, "Not found key"), else: result
  end

  def merge(list1, list2), do: list1 ++ list2
end
