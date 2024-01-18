defmodule Elform.Validators.Map.MapEqualityTest do
  use ExUnit.Case

  @map %{
    "email" => Faker.Internet.email(),
    "password" => Faker.String.base64()
  }

  describe "when the map is different from that required" do
    test "should return a schema error" do
      schema = %{
        label: "login",
        validators: [map_equality: @map]
      }

      payload = %{"login" => %{}}
      response = Elform.validate(schema, payload)

      map_string =
        Map.to_list(@map)
        |> Enum.map_join(",", fn {k, v} -> "#{k}: #{v}" end)

      expected_response = %{
        "login" => [map_equality: "the map should be equal to {#{map_string}}"]
      }

      assert response == expected_response
    end
  end

  describe "when the map is equal to the required" do
    test "should return ':ok'" do
      schema = %{
        label: "login",
        validators: [map_equality: @map]
      }

      payload = %{"login" => @map}
      response = Elform.validate(schema, payload)
      expected_response = %{"login" => :ok}

      assert response == expected_response
    end
  end
end
