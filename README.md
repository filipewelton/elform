# Elform
[![codecov](https://codecov.io/gh/filipewelton/elform/graph/badge.svg?token=8HSK2N9S8F)](https://codecov.io/gh/filipewelton/elform)

## Description
Provide multiple functions for data validation and operators for most specific validation. The data types accepted are string, number, boolean, list, or map.

## Inspirations
nimble_options - https://hex.pm/packages/nimble_options

yup - https://github.com/jquense/yup

## Concepts
There are two concepts: schemas, and validators.

### Schema
The structure that determines the requirements of data must follow to be valid.

- The 'label' property should be a string that labels the data.

- The 'required' property should be a boolean, indicating whether the data is required.

- The 'validators' property should be a list of keywords or atoms to determine the validations.

### Validators
These are modules that validate data.
