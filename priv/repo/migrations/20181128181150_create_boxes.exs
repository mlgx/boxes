defmodule Boxes.Repo.Migrations.CreateBoxes do
  use Ecto.Migration

  def change do
    # No primary key because the uniqueness of boxes is on "id + parent IS NULL".
    create table(:boxes, primary_key: false) do
      add(:id, :bigint, null: false)
      # Parent references id. But id is not unique so the reference can't be setup here.
      add(:parent, :bigint)
      add(:name, :string)
      add(:description, :string)
    end

    create(index(:boxes, [:id]))
    create(index(:boxes, [:parent]))

    # When creating a relationshipt, check if box id and parent id exists.
    execute("CREATE OR REPLACE FUNCTION relationship_validation_trigger() RETURNS trigger AS $$
              BEGIN
                IF NEW.parent IS NOT NULL THEN -- If we can creating a relationshipt.
                  IF NEW.id NOT IN (SELECT id FROM boxes WHERE parent IS NULL) THEN
                    RAISE EXCEPTION 'box does not exist';
                  END IF;
                  IF NEW.parent NOT IN (SELECT id FROM boxes WHERE parent IS NULL) THEN
                    RAISE EXCEPTION 'parent box does not exist';
                  END IF;
                END IF;
                RETURN NEW;
              END
             $$ LANGUAGE plpgsql")

    execute("CREATE TRIGGER relationship_validation
              BEFORE INSERT OR UPDATE ON boxes
              FOR EACH ROW EXECUTE PROCEDURE relationship_validation_trigger()")

    # TODO: add trigger to enforce row types.
    # There's two types of rows in this table (which should normally be split into multiple tables).
    # The first type of rows describes a box. Its properties are:
    #  - name IS NOT NULL
    #  - parent IS NULL
    # The second type describes relationships between boxes:
    #  - name IS NULL
    #  - parent IS NOT NULL

    # TODO: enforce uniqueness on ID + parent IS NULL (or ID + name IS NOT NULL)
  end
end
