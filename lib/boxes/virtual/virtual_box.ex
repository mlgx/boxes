defmodule Boxes.Virtual.VirtualBox do
  @moduledoc """
  Virtual Box model.
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias Boxes.Virtual.VirtualRelationship

  schema "virtual_boxes" do
    field(:name, :string)
    field(:description, :string)

    timestamps()

    has_one(:virtual_parent_relationship, VirtualRelationship, foreign_key: :box_id)
    has_many(:virtual_children_relationships, VirtualRelationship, foreign_key: :parent_id)

    has_one(:virtual_parent, through: [:virtual_parent_relationship, :parent])
    has_many(:virtual_children, through: [:virtual_children_relationships, :box])
  end

  @doc false
  def changeset(virtual_box, attrs) do
    virtual_box
    |> cast(attrs, [:name, :description])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
