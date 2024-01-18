defmodule Elform.Validators.List.ListEqualityTest do
  use ExUnit.Case

  describe "call/2" do
    @list Faker.Lorem.words()

    test "when the list is different from that required" do
      schema = %{
        label: "words",
        validators: [list_equality: @list]
      }

      payload = %{"words" => Faker.Lorem.words()}
      response = Elform.validate(schema, payload)
      list = Enum.sort(@list) |> Enum.join(",")

      expected_response =
        %{"words" => [list_equality: "the list should be equal to [#{list}]"]}

      assert response == expected_response
    end

    test "when the list is equal to the required" do
      schema = %{
        label: "words",
        validators: [list_equality: @list]
      }

      payload = %{"words" => @list}
      response = Elform.validate(schema, payload)
      expected_response = %{"words" => :ok}

      assert response == expected_response
    end
  end
end
