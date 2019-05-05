defmodule Boxes.Repo.Migrations.CreateVirtualBoxesRelationships do
  use Ecto.Migration

  def change do
    create table(:virtual_boxes_relationships) do
      add(:box_id, references(:virtual_boxes), null: false)
      add(:parent_id, references(:virtual_boxes), null: false)

      timestamps()
    end

    create(unique_index(:virtual_boxes_relationships, :box_id))
  end
end
