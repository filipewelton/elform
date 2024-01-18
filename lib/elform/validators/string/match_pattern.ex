defmodule Elform.Validators.String.MatchPattern do
  @behaviour Elform.Validators.Behaviour

  use Elform.Utilities.ValidatorActionFallback, name: :match_pattern, type: :string

  def call(value, args) do
    case Regex.match?(args, value) do
      true -> :ok
      false -> [match_pattern: "the value does not match the pattern"]
    end
  rescue
    _error in FunctionClauseError -> [match_pattern: "argument should be a regex"]
  end
end
