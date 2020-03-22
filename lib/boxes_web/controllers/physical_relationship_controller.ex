defmodule BoxesWeb.PhysicalRelationshipController do
  use BoxesWeb, :controller

  import Phoenix.HTML.Link

  alias BoxesWeb.QueryFilter

  alias Boxes.Physical
  alias Boxes.Physical.PhysicalRelationship

  def index(conn, _params) do
    physical_boxes_relationships = Physical.list_physical_boxes_relationships(%{preload: [:box, :parent]})
    render(conn, "index.html", physical_boxes_relationships: physical_boxes_relationships)
  end

  def new(conn, params) do
    changeset = Physical.change_physical_relationship(%PhysicalRelationship{})
    physical_boxes = Physical.list_physical_boxes()
    params = QueryFilter.changeset(%PhysicalRelationship{}, params)
    render(conn, "new.html", changeset: changeset, physical_boxes: physical_boxes, params: params)
  end

  def create(conn, %{"physical_relationship" => physical_relationship_params}) do
    case Physical.create_physical_relationship(physical_relationship_params) do
      {:ok, physical_relationship} ->
        conn
        |> put_flash(:info, ["Physical relationship created successfully.", link("Create new one?", to: Routes.physical_relationship_path(conn, :new))])
        |> redirect(to: Routes.physical_relationship_path(conn, :show, physical_relationship))

      {:error, %Ecto.Changeset{} = changeset} ->
        physical_boxes = Physical.list_physical_boxes()
        render(conn, "new.html", changeset: changeset, physical_boxes: physical_boxes, params: [])
    end
  end

  def show(conn, %{"id" => id}) do
    physical_relationship = Physical.get_physical_relationship!(id, %{preload: [:box, :parent]})
    render(conn, "show.html", physical_relationship: physical_relationship)
  end

  def edit(conn, %{"id" => id}) do
    physical_boxes = Physical.list_physical_boxes()
    physical_relationship = Physical.get_physical_relationship!(id)
    changeset = Physical.change_physical_relationship(physical_relationship)
    render(conn, "edit.html", physical_boxes: physical_boxes, physical_relationship: physical_relationship, changeset: changeset, params: [])
  end

  def update(conn, %{"id" => id, "physical_relationship" => physical_relationship_params}) do
    physical_relationship = Physical.get_physical_relationship!(id)

    case Physical.update_physical_relationship(
           physical_relationship,
           physical_relationship_params
         ) do
      {:ok, physical_relationship} ->
        conn
        |> put_flash(:info, "Physical relationship updated successfully.")
        |> redirect(to: Routes.physical_relationship_path(conn, :show, physical_relationship))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html",
          physical_relationship: physical_relationship,
          changeset: changeset
        )
    end
  end

  def delete(conn, %{"id" => id}) do
    physical_relationship = Physical.get_physical_relationship!(id)
    {:ok, _physical_relationship} = Physical.delete_physical_relationship(physical_relationship)

    conn
    |> put_flash(:info, "Physical relationship deleted successfully.")
    |> redirect(to: Routes.physical_relationship_path(conn, :index))
  end
end
