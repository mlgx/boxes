defmodule Boxes.Virtual.VirtualRelationship do
  @moduledoc """
  Virtual Relationship model.
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias Boxes.Virtual.VirtualBox

  schema "virtual_boxes_relationships" do
    belongs_to(:box, VirtualBox)
    belongs_to(:parent, VirtualBox)

    timestamps()
  end

  @doc false
  def changeset(virtual_relationship, attrs) do
    virtual_relationship
    |> cast(attrs, [:box_id, :parent_id])
    |> validate_required([:box_id, :parent_id])
    |> foreign_key_constraint(:box_id)
    |> foreign_key_constraint(:parent_id)
  end
end
