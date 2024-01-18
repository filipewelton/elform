defmodule Elform.Validators.Number.PrimeNumber do
  @behaviour Elform.Validators.Behaviour

  use Elform.Utilities.ValidatorActionFallback, name: :prime_number, type: :number

  require Integer

  def call(value) do
    cond do
      value in [2, 3, 5, 7] -> :ok
      prime?(value) -> :ok
      true -> [prime_number: "the value should be a prime number"]
    end
  end

  defp prime?(n) do
    floored_sqrt =
      :math.sqrt(n)
      |> Float.floor()
      |> round

    not Enum.any?(2..floored_sqrt, &(rem(n, &1) == 0))
  end
end
