defmodule Boxes.Repo.Migrations.CreateVirtualBoxes do
  use Ecto.Migration

  def change do
    create table(:virtual_boxes) do
      add(:name, :string, null: false)
      add(:description, :string)

      timestamps()
    end

    create(unique_index(:virtual_boxes, :name))
  end
end
