defmodule BoxesWeb.PhysicalBoxController do
  use BoxesWeb, :controller

  import Phoenix.HTML.Link

  alias Boxes.Physical
  alias Boxes.Physical.PhysicalBox

  def index(conn, _params) do
    physical_boxes = Physical.list_physical_boxes()
    render(conn, "index.html", physical_boxes: physical_boxes)
  end

  def new(conn, _params) do
    changeset = Physical.change_physical_box(%PhysicalBox{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"physical_box" => physical_box_params}) do
    case Physical.create_physical_box(physical_box_params) do
      {:ok, physical_box} ->
        conn
        |> put_flash(:info, ["Physical box created successfully. ", link("Create new one?", to: physical_box_path(conn, :new))])
        |> redirect(to: physical_box_path(conn, :show, physical_box))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    physical_box = Physical.get_physical_box!(id, %{preload: [:physical_parents, :physical_children]})
    render(conn, "show.html", physical_box: physical_box)
  end

  def edit(conn, %{"id" => id}) do
    physical_box = Physical.get_physical_box!(id)
    changeset = Physical.change_physical_box(physical_box)
    render(conn, "edit.html", physical_box: physical_box, changeset: changeset)
  end

  def update(conn, %{"id" => id, "physical_box" => physical_box_params}) do
    physical_box = Physical.get_physical_box!(id)

    case Physical.update_physical_box(physical_box, physical_box_params) do
      {:ok, physical_box} ->
        conn
        |> put_flash(:info, "Physical box updated successfully.")
        |> redirect(to: physical_box_path(conn, :show, physical_box))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", physical_box: physical_box, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    physical_box = Physical.get_physical_box!(id)
    {:ok, _physical_box} = Physical.delete_physical_box(physical_box)

    conn
    |> put_flash(:info, "Physical box deleted successfully.")
    |> redirect(to: physical_box_path(conn, :index))
  end
end
