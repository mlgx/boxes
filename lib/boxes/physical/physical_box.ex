defmodule Boxes.Physical.PhysicalBox do
  use Ecto.Schema
  import Ecto.Changeset


  schema "physical_boxes" do
    field :description, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(physical_box, attrs) do
    physical_box
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
  end
end
