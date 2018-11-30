defmodule Boxes.Repo.Migrations.CreatePhysicalBoxesRelationships do
  use Ecto.Migration

  def change do
    create table(:physical_boxes_relationships) do
      add(:box_id, references(:physical_boxes), null: false)
      add(:parent_id, references(:physical_boxes), null: false)

      timestamps()
    end
  end
end
