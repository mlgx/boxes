defmodule Boxes.Physical.PhysicalBox do
  @moduledoc """
  Physical Box model.
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias Boxes.Physical.PhysicalRelationship

  schema "physical_boxes" do
    field(:name, :string)
    field(:description, :string)

    timestamps()

    has_many(:physical_parents_relationships, PhysicalRelationship, foreign_key: :box_id)
    has_many(:physical_children_relationships, PhysicalRelationship, foreign_key: :parent_id)

    has_many(:physical_parents, through: [:physical_parents_relationships, :parent])
    has_many(:physical_children, through: [:physical_children_relationships, :box])
  end

  @doc false
  def changeset(physical_box, attrs) do
    physical_box
    |> cast(attrs, [:name, :description])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
