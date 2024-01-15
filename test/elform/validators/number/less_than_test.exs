defmodule Validators.Elform.Number.LessThanTest do
  use ExUnit.Case
  use Elform

  describe "call/2" do
    @number :rand.uniform(99)

    test "when the value is greater than #{@number}" do
      schema = %{
        label: "age",
        validators: [less_than: @number]
      }

      payload = %{"age" => @number + 1}
      response = validate(schema, payload)
      expected_response = %{"age" => [less_than: "the value must be less than #{@number}"]}

      assert response == expected_response
    end

    test "when the value is less than #{@number}" do
      schema = %{
        label: "age",
        validators: [less_than: @number]
      }

      payload = %{"age" => @number - 1}
      response = validate(schema, payload)
      expected_response = %{"age" => :ok}

      assert response == expected_response
    end
  end
end
