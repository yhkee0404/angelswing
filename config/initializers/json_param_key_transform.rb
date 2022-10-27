# https://stackoverflow.com/a/57004117
# File: config/initializers/json_param_key_transform.rb
# Transform JSON request param keys from JSON-conventional camelCase to
# Rails-conventional snake_case:
ActionDispatch::Request.parameter_parsers[:json] = (
  # Compose the original parser with a transformation
  ActionDispatch::Request.parameter_parsers[:json] >>
    # Transform camelCase param keys to snake_case
    ->(data) {
      data.deep_transform_keys(&:underscore)
    }
)