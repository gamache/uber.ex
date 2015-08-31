defmodule Uber.Data do
  defstruct id: nil,             # string
            name: nil,           # string
            rel: nil,            # array of strings
            label: nil,          # string
            url: nil,            # string
            templated: false,    # boolean
            action: "read",      # string
            transclude: "false", #
            model: nil,          # "contains a template"
            sending: nil,        # array of strings
            accepting: nil,      # array of strings
            value: nil,          # value of this datum
            version: "1.0"       # string

  @transclude_values ~w(true false audio image text video)
  @action_values ~w(append partial read remove replace)

  def validate(data) do
    transclude_error(data) ++
      action_error(data) ++
      validate_string(data, [:id, :name, :label, :url, :version]) ++
      validate_list_of_strings(data, [:rel, :sending, :accepting])
  end

  defp transclude_error(data) do
    if !Enum.member?(@transclude_values, data.transclude) do
      [{:transclude, "must be one of: " <> Enum.join(@transclude_values, ", ")}]
    else
      []
    end
  end

  defp action_error(data) do
    if !Enum.member?(@action_values, data.action) do
      [{:action, "must be one of: " <> Enum.join(@action_values, ", ")}]
    else
      []
    end
  end

  defp validate_string(data, fields) do
    validate_string(data, fields, [])
  end

  defp validate_string(data, fields, acc) do
    case fields do
      [] ->
        acc
      [field | rest] ->
        value = Map.get(data, field)
        error = if value != nil && !is_binary(value) do
          [{field, "must be a string"}]
        else
          []
        end
        validate_string(data, rest, acc ++ error)
    end
  end

  defp validate_list_of_strings(data, fields) do
    validate_list_of_strings(data, fields, [])
  end

  defp validate_list_of_strings(data, fields, acc) do
    case fields do
      [] ->
        acc
      [field | rest] ->
        value = Map.get(data, field)
        error = if value != nil && (!is_list(value) ||
                    Enum.any?(value, fn(d) -> !is_binary(d) end)) do
          [{field, "must be a list of strings"}]
        else
          []
        end
        validate_list_of_strings(data, rest, acc ++ error)
    end
  end
end

