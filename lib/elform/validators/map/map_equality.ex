defmodule Elform.Validators.Map.MapEquality do
  @behaviour Elform.Validators.Behaviour

  use Elform.Utilities.ValidatorActionFallback, name: :map_equality, type: :map

  def call(value, args) do
    k1 = Map.keys(value) |> Enum.sort() |> Enum.join(",")
    v1 = Map.values(args) |> Enum.sort() |> Enum.join(",")
    k2 = Map.keys(args) |> Enum.sort() |> Enum.join(",")
    v2 = Map.values(args) |> Enum.sort() |> Enum.join(",")
    parsed_map = Enum.map_join(args, ",", &parse_map_in_string/1)

    case k1 === k2 and v1 === v2 do
      true -> :ok
      false -> [map_equality: "the map should be equal to {#{parsed_map}}"]
    end
  end

  defp parse_map_in_string({key, value}), do: "#{key}: #{value}"
end
