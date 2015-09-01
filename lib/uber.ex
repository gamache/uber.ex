defmodule Uber do
  @moduledoc """
  Provides structures to represent and validate UBER documents, as set
  forth in the specification at http://uberhypermedia.org/.
  """

  defstruct data: [],
            error: [],
            profile: nil

  @doc """
  Returns [] on valid input, or a list of {field, error_reason}.
  """
  def validate(uber) do
    import Uber.Validations
    validate_string(uber, [:profile]) ++
      validate_list_of_type(uber, [:data], Uber.Data) ++
      validate_list_of_type(uber, [:error], Uber.Error)
  end

  @spec add_data(Uber, [Uber.Data]) :: Uber
  def add_data(uber, data) do
    %Uber{uber | data: uber.data ++ data}
  end

  @spec add_error(Uber, [Uber.Error]) :: Uber
  def add_error(uber, error) do
    %Uber{uber | error: uber.error ++ error}
  end
end
