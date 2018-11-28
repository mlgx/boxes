defmodule Boxes.Repo.Migrations.CreateBoxes do
  use Ecto.Migration

  def change do
    create table(:boxes, primary_key: false) do
      add(:id, :bigint, null: false)
      add(:parent, :bigint)
      add(:name, :string)
      add(:description, :string)
    end

    create(index(:boxes, [:id]))
    create(index(:boxes, [:parent]))

    # TODO: add trigger that checks if parent ID exists in the table.
  end
end
