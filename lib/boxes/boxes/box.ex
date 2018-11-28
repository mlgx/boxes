defmodule Boxes.Boxes.Box do
  use Ecto.Schema
  import Ecto.Changeset

  @allowed_fields [:id, :parent, :name, :description]
  @required_fields [:name]

  @primary_key false
  schema "boxes" do
    field :id, :integer
    field :parent, :integer
    field :name, :string
    field :description, :string
  end

  @doc false
  def changeset(box, attrs) do
    box
    |> cast(attrs, @allowed_fields)
    |> validate_required(@required_fields)
  end
end
