defmodule Elform.Validators.Number.GreaterThanTest do
  use ExUnit.Case
  use Elform

  describe "call/2" do
    @number :rand.uniform(99)

    test "when the value is less than #{@number}" do
      schema = %{
        label: "age",
        validators: [greater_than: @number]
      }

      payload = %{"age" => @number - 1}
      response = validate(schema, payload)
      expected_response = %{"age" => [greater_than: "the value must be greater than #{@number}"]}

      assert response == expected_response
    end

    test "when the value is greater than #{@number}" do
      schema = %{
        label: "age",
        validators: [greater_than: @number]
      }

      payload = %{"age" => @number + 1}
      response = validate(schema, payload)
      expected_response = %{"age" => :ok}

      assert response == expected_response
    end
  end
end
