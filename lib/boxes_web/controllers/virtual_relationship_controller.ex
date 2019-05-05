defmodule BoxesWeb.VirtualRelationshipController do
  use BoxesWeb, :controller
  alias BoxesWeb.QueryFilter

  alias Boxes.Virtual
  alias Boxes.Virtual.VirtualRelationship

  def index(conn, _params) do
    virtual_boxes_relationships = Virtual.list_virtual_boxes_relationships()
    render(conn, "index.html", virtual_boxes_relationships: virtual_boxes_relationships)
  end

  def new(conn, params) do
    changeset = Virtual.change_virtual_relationship(%VirtualRelationship{})
    virtual_boxes = Boxes.Virtual.list_virtual_boxes()
    params = QueryFilter.changeset(%VirtualRelationship{}, params)
    render(conn, "new.html", changeset: changeset, virtual_boxes: virtual_boxes, params: params)
  end

  def create(conn, %{"virtual_relationship" => virtual_relationship_params}) do
    case Virtual.create_virtual_relationship(virtual_relationship_params) do
      {:ok, virtual_relationship} ->
        conn
        |> put_flash(:info, "Virtual relationship created successfully.")
        |> redirect(to: virtual_relationship_path(conn, :show, virtual_relationship))

      {:error, %Ecto.Changeset{} = changeset} ->
        virtual_boxes = Boxes.Virtual.list_virtual_boxes()
        render(conn, "new.html", changeset: changeset, virtual_boxes: virtual_boxes, params: [])
    end
  end

  def show(conn, %{"id" => id}) do
    virtual_relationship = Virtual.get_virtual_relationship!(id)
    render(conn, "show.html", virtual_relationship: virtual_relationship)
  end

  def edit(conn, %{"id" => id}) do
    virtual_relationship = Virtual.get_virtual_relationship!(id)
    changeset = Virtual.change_virtual_relationship(virtual_relationship)
    render(conn, "edit.html", virtual_relationship: virtual_relationship, changeset: changeset)
  end

  def update(conn, %{"id" => id, "virtual_relationship" => virtual_relationship_params}) do
    virtual_relationship = Virtual.get_virtual_relationship!(id)

    case Virtual.update_virtual_relationship(
           virtual_relationship,
           virtual_relationship_params
         ) do
      {:ok, virtual_relationship} ->
        conn
        |> put_flash(:info, "Virtual relationship updated successfully.")
        |> redirect(to: virtual_relationship_path(conn, :show, virtual_relationship))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html",
          virtual_relationship: virtual_relationship,
          changeset: changeset
        )
    end
  end

  def delete(conn, %{"id" => id}) do
    virtual_relationship = Virtual.get_virtual_relationship!(id)
    {:ok, _virtual_relationship} = Virtual.delete_virtual_relationship(virtual_relationship)

    conn
    |> put_flash(:info, "Virtual relationship deleted successfully.")
    |> redirect(to: virtual_relationship_path(conn, :index))
  end
end
