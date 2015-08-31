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
      string_validate(data, [:id, :name, :label, :url, :version]) ++
      list_of_strings_validate(data, [:rel, :sending, :accepting])
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

  defp string_validate(data, fields) do
    string_validate(data, fields, [])
  end

  defp string_validate(data, fields, acc) do
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
        string_validate(data, rest, acc ++ error)
    end
  end

  defp list_of_strings_validate(data, fields) do
    list_of_strings_validate(data, fields, [])
  end

  defp list_of_strings_validate(data, fields, acc) do
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
        list_of_strings_validate(data, rest, acc ++ error)
    end
  end
end

