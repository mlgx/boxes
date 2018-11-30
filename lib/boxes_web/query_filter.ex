defmodule BoxesWeb.QueryFilter do
  @moduledoc """
  A module poviding fuctions to process query parameters passed to controllers.
  """

  def changeset(module, params) when is_atom(module) do
    module
    |> struct()
    |> module.changeset(params)
    |> Map.fetch!(:changes)
    |> Map.to_list()
  end

  def changeset(model, params) when is_map(model) do
    model
    |> model.__struct__.changeset(params)
    |> Map.fetch!(:changes)
    |> Map.to_list()
  end
end
