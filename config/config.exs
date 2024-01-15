import Config

config :elform,
  default_validators: [
    length: Elform.Validations.String.Length,
    contains: Elform.Validations.String.Contains,
    length_greater_than: Elform.Validations.String.LengthGreaterThan,
    length_less_than: Elform.Validations.String.LengthLessThan,
    text_equality: Elform.Validations.String.TextEquality,
    greater_than: Elform.Validations.Number.GreaterThan,
    less_than: Elform.Validations.Number.LessThan,
    numeric_equality: Elform.Validations.Number.NumericEquality,
    must_be: Elform.Validations.Number.MustBe,
    list_equality: Elform.Validations.List.ListEquality,
    map_equality: Elform.Validations.Map.MapEquality
  ]
