defmodule Boxes.Repo.Migrations.CreatePhysicalBoxesRelationships do
  use Ecto.Migration

  def change do
    create table(:physical_boxes_relationships, primary_key: false) do
      add(:id, :integer, null: false, references(:physical_boxes))
      add(:parent_id, :integer, null: false, references(:physical_boxes))

      timestamps()
    end
  end
end
