defmodule Boxes.Repo.Migrations.CreatePhysicalBoxes do
  use Ecto.Migration

  def change do
    create table(:physical_boxes) do
      add(:name, :string, unique: true, null: false)
      add(:description, :string)

      timestamps()
    end
  end
end
