defmodule Elform.Utilities.KeyList do
  def valid?(list) when list === [], do: true

  def valid?(list) when is_list(list) do
    not Enum.any?(list, fn e ->
      not is_atom(e) and not is_tuple(e)
    end)
  end

  def valid?(_), do: false

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
end
