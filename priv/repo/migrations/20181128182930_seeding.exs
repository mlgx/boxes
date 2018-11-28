defmodule Boxes.Repo.Migrations.Seeding do
  @moduledoc """
  This seeding is mandatory.
  The rows added here are part of the schema.
  Their IDs are important. It must be 1 for Physical and 2 for Virtual.

  Unlike regular seeds they are needed when running `mix test`.
  """
  use Ecto.Migration

  def up do
    execute("CREATE SEQUENCE boxes_id_seq START 1")

    alter table(:boxes) do
      modify(:id, :bigint, default: fragment("nextval('boxes_id_seq'::regclass)"))
    end

    execute("INSERT INTO boxes (name) VALUES ('Physical Box')")
    execute("INSERT INTO boxes (name) VALUES ('Virtual Box')")
  end

  def down do
    execute("DELETE FROM boxes WHERE id IN (1, 2)")

    alter table(:boxes) do
      modify(:id, :bigint, default: nil)
    end

    execute("DROP SEQUENCE boxes_id_seq")
  end
end
