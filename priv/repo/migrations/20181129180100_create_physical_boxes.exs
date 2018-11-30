defmodule Boxes.Repo.Migrations.CreatePhysicalBoxes do
  use Ecto.Migration

  def change do
    create table(:physical_boxes) do
      add(:name, :string, null: false)
      add(:description, :string)

      timestamps()
    end

    create(unique_index(:physical_boxes, :name))
  end
end
