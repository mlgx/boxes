defmodule BoxesWeb.PhysicalRelationshipController do
  use BoxesWeb, :controller

  alias Boxes.Physical
  alias Boxes.Physical.PhysicalRelationship

  def index(conn, _params) do
    physical_boxes_relationships = Physical.list_physical_boxes_relationships()
    render(conn, "index.html", physical_boxes_relationships: physical_boxes_relationships)
  end

  def new(conn, _params) do
    changeset = Physical.change_physical_relationship(%PhysicalRelationship{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"physical_relationship" => physical_relationship_params}) do
    case Physical.create_physical_relationship(physical_relationship_params) do
      {:ok, physical_relationship} ->
        conn
        |> put_flash(:info, "Physical relationship created successfully.")
        |> redirect(to: physical_relationship_path(conn, :show, physical_relationship))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    physical_relationship = Physical.get_physical_relationship!(id)
    render(conn, "show.html", physical_relationship: physical_relationship)
  end

  def edit(conn, %{"id" => id}) do
    physical_relationship = Physical.get_physical_relationship!(id)
    changeset = Physical.change_physical_relationship(physical_relationship)
    render(conn, "edit.html", physical_relationship: physical_relationship, changeset: changeset)
  end

  def update(conn, %{"id" => id, "physical_relationship" => physical_relationship_params}) do
    physical_relationship = Physical.get_physical_relationship!(id)

    case Physical.update_physical_relationship(physical_relationship, physical_relationship_params) do
      {:ok, physical_relationship} ->
        conn
        |> put_flash(:info, "Physical relationship updated successfully.")
        |> redirect(to: physical_relationship_path(conn, :show, physical_relationship))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", physical_relationship: physical_relationship, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    physical_relationship = Physical.get_physical_relationship!(id)
    {:ok, _physical_relationship} = Physical.delete_physical_relationship(physical_relationship)

    conn
    |> put_flash(:info, "Physical relationship deleted successfully.")
    |> redirect(to: physical_relationship_path(conn, :index))
  end
end
