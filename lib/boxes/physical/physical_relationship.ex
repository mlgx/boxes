defmodule Boxes.Physical.PhysicalRelationship do
  use Ecto.Schema
  import Ecto.Changeset

  alias Boxes.Physical.PhysicalBox

  schema "physical_boxes_relationships" do
    belongs_to(:box, PhysicalBox)
    belongs_to(:parent, PhysicalBox)

    timestamps()
  end

  @doc false
  def changeset(physical_relationship, attrs) do
    physical_relationship
    |> cast(attrs, [:box_id, :parent_id])
    |> validate_required([:box_id, :parent_id])
    |> foreign_key_constraint(:box_id)
    |> foreign_key_constraint(:parent_id)
  end
end
