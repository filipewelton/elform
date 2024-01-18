import Config

config :elform,
  validators: [
    match_pattern: Elform.Validators.String.MatchPattern,
    length: Elform.Validators.String.Length,
    contains: Elform.Validators.String.Contains,
    length_greater_than: Elform.Validators.String.LengthGreaterThan,
    length_less_than: Elform.Validators.String.LengthLessThan,
    text_equality: Elform.Validators.String.TextEquality,
    greater_than: Elform.Validators.Number.GreaterThan,
    less_than: Elform.Validators.Number.LessThan,
    numeric_equality: Elform.Validators.Number.NumericEquality,
    odd_number: Elform.Validators.Number.OddNumber,
    even_number: Elform.Validators.Number.EvenNumber,
    prime_number: Elform.Validators.Number.PrimeNumber,
    list_equality: Elform.Validators.List.ListEquality,
    map_equality: Elform.Validators.Map.MapEquality,
    and: Elform.Operators.And,
    or: Elform.Operators.Or
  ]
