defmodule Boxes.Boxes.Box do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  schema "boxes" do
    field(:id, :integer, read_after_writes: true)
    field(:parent, :integer)
    field(:name, :string)
    field(:description, :string)

    field(:virtual, :boolean, default: false, virtual: true)
  end

  @doc false
  def changeset(box, attrs) do
    box
    |> cast(attrs, [:id, :parent, :name, :description])
    |> validate_required([:name])
  end

  @doc """
  Create a new box.
  Parent must be NULL and ID must come from the sequence.
  """
  def create_box_changeset(box, attrs) do
    box
    |> cast(attrs, [:name, :description])
    |> validate_required([:name])
  end

  @doc "
  Create a box relationship
  Parent and ID must be set, and name and description must be NULL.
  "
  def create_relationship_changeset(box, attrs) do
    box
    |> cast(attrs, [:id, :parent])
    |> validate_required([:id, :parent])
  end

  @doc "
  Update box data.
  ID must be set. Name and description can be set. Parent must be NULL.
  "
  def update_box_changeset(box, attrs) do
    box
    |> cast(attrs, [:id, :name, :description])
    |> validate_required([:id])
  end

  def update_relationship_changeset(box, attrs) do
    box
    |> cast(attrs, [:id, :parent])
    |> validate_required([:id])
    |> validate_inclusion(:name, [nil])
  end
end
