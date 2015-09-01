defmodule Uber.Validations do
  def validate_inclusion(data, field, list) do
    value = Map.get(data, field)
    if value && !Enum.member?(list, value) do
      [{field, "must be one of: " <> Enum.join(list, ", ")}]
    else
      []
    end
  end

  def validate_string(data, fields) do
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

  def validate_list_of_strings(data, fields) do
    validate_list_of_strings(data, fields, [])
  end

  defp validate_list_of_strings(data, fields, acc) do
    case fields do
      [] ->
        acc
      [field | rest] ->
        value = Map.get(data, field)
        error = if value == nil ||
                   !is_list(value) ||
                   Enum.any?(value, fn(d) -> !is_binary(d) end) do
          [{field, "must be a list of strings"}]
        else
          []
        end
        validate_list_of_strings(data, rest, acc ++ error)
    end
  end

  def validate_list_of_type(data, fields, type) do
    validate_list_of_type(data, fields, type, [])
  end
  defp validate_list_of_type(data, fields, type, acc) do
    case fields do
      [] -> acc
      [field | rest] ->
        value = Map.get(data, field)
        error = if value == nil ||
                   !is_list(value) ||
                   Enum.any?(value, fn(d) -> !(is_map(d) && d.__struct__ == type) end) do
          [{field, "must be a list of " <> to_string(type)}]
        else
          []
        end
        validate_list_of_type(data, rest, type, acc ++ error)
    end
  end

end
