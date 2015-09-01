defmodule Uber.Fields do
  defmacro define_fields do
    quote do
      defstruct id: nil,             # string
                name: nil,           # string
                rel: [],             # [string]
                label: nil,          # string
                url: nil,            # string
                templated: false,    # boolean
                action: "read",      # string
                transclude: "false", # string
                model: nil,          # string (URI Template)
                sending: [],         # [string]
                accepting: [],       # [string]
                value: nil,          # value of this datum
                version: "1.0",      # string
                data: []             # [Uber.Data]

      @transclude_values ~w(true false audio image text video)
      @action_values ~w(append partial read remove replace)

      def validate(data) do
        import Uber.Validations
        validate_inclusion(data, :transclude, @transclude_values) ++
          validate_inclusion(data, :action, @action_values) ++
          validate_string(data, [:id, :name, :label, :url, :version, :model]) ++
          validate_list_of_strings(data, [:rel, :sending, :accepting]) ++
          validate_list_of_type(data, [:data], Uber.Data)
      end
    end
  end

end
