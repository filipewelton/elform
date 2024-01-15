defmodule Elform.Validators.Map.MapEqualityTest do
  use ExUnit.Case
  use Elform

  describe "call/2" do
    @map %{
      "email" => Faker.Internet.email(),
      "password" => Faker.String.base64()
    }

    test "when the map is different from that required" do
      schema = %{
        label: "login",
        validators: [map_equality: @map]
      }

      payload = %{"login" => %{}}
      response = validate(schema, payload)

      map_string =
        Map.to_list(@map)
        |> Enum.map_join(",", fn {k, v} -> "#{k}: #{v}" end)

      expected_response = %{
        "login" => [map_equality: "the map must be equal to {#{map_string}}"]
      }

      assert response == expected_response
    end

    test "when the map is equal to the required" do
      schema = %{
        label: "login",
        validators: [map_equality: @map]
      }

      payload = %{"login" => @map}
      response = validate(schema, payload)
      expected_response = %{"login" => :ok}

      assert response == expected_response
    end
  end
end
