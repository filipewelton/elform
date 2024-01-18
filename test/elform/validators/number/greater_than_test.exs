defmodule Elform.Validators.Number.GreaterThanTest do
  use ExUnit.Case

  @number :rand.uniform(99)

  describe "when the value is less than #{@number}" do
    test "should return a schema error" do
      schema = %{
        label: "age",
        validators: [greater_than: @number]
      }

      payload = %{"age" => @number - 1}
      response = Elform.validate(schema, payload)

      expected_response = %{
        "age" => [greater_than: "the value should be greater than #{@number}"]
      }

      assert response == expected_response
    end
  end

  describe "when the value is greater than #{@number}" do
    test "should return ':ok'" do
      schema = %{
        label: "age",
        validators: [greater_than: @number]
      }

      payload = %{"age" => @number + 1}
      response = Elform.validate(schema, payload)
      expected_response = %{"age" => :ok}

      assert response == expected_response
    end
  end
end
