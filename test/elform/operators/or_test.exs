defmodule Elform.Operators.OrTest do
  use ExUnit.Case

  alias Faker.Address.{En, Es, PtBr}

  describe "when the value does not match any of the conditions" do
    test "should return multiple errors" do
      addr1 = En.city()
      addr2 = PtBr.city()
      addr3 = Es.city()

      schema = %{
        label: "address",
        validators: [
          or: [text_equality: addr1, text_equality: addr2]
        ]
      }

      payload = %{"address" => addr3}
      response = Elform.validate(schema, payload)

      expected_response = %{
        "address" => [
          or: [
            "text should be equal to '#{addr1}'",
            "text should be equal to '#{addr2}'"
          ]
        ]
      }

      assert response == expected_response
    end
  end

  describe "when the value of match all conditions" do
    test "should return ':ok'" do
      addr1 = En.city()
      addr2 = PtBr.city()

      schema = %{
        label: "address",
        validators: [
          or: [text_equality: addr1, text_equality: addr2]
        ]
      }

      payload = %{"address" => addr2}
      response = Elform.validate(schema, payload)
      expected_response = %{"address" => :ok}

      assert response == expected_response
    end
  end

  describe "when there is an invalid argument" do
    test "should throw argument error" do
      text = Faker.Lorem.word()

      schema = %{
        label: "text",
        validators: [or: nil]
      }

      payload = %{"text" => text}

      assert_raise(ArgumentError, fn -> Elform.validate(schema, payload) end)
    end
  end
end
