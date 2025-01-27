defmodule ExStatichostEu.Model.AddSite do
  @derive Jason.Encoder
  defstruct [
    :name,
    :repository
  ]
end
