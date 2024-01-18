defmodule Elform.Validators.Behaviour do
  @typep value :: map() | number() | boolean() | list() | String.t()
  @typep args :: number() | tuple() | map() | list() | Regex.t() | String.t()
  @typep reply :: :ok | keyword()

  @callback call(value(), args()) :: reply()
end
