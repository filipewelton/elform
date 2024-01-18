defmodule Elform.Validators.String.TextEqualityTest do
  use ExUnit.Case

  @word Faker.Lorem.word()

  describe "when the text is different from the #{@word}" do
    test "should return a schema error" do
      schema = %{
        label: "word",
        required: true,
        validators: [text_equality: @word]
      }

      payload = %{"word" => Faker.Lorem.word()}
      response = Elform.validate(schema, payload)

      expected_response = %{
        "word" => [text_equality: "text should be equal to '#{@word}'"]
      }

      assert response == expected_response
    end
  end

  describe "when the text is equal to #{@word}" do
    test "should return ':ok'" do
      schema = %{
        label: "word",
        required: true,
        validators: [text_equality: @word]
      }

      payload = %{"word" => @word}
      response = Elform.validate(schema, payload)
      expected_response = %{"word" => :ok}

      assert response == expected_response
    end
  end
end
