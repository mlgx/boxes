defmodule Boxes.Physical.PhysicalRelationship do
  use Ecto.Schema
  import Ecto.Changeset


  schema "physical_boxes_relationships" do
    field :id, :integer
    field :parent_id, :integer

    timestamps()
  end

  @doc false
  def changeset(physical_relationship, attrs) do
    physical_relationship
    |> cast(attrs, [:id, :parent_id])
    |> validate_required([:id, :parent_id])
  end
end
