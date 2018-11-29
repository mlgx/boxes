defmodule BoxesWeb.BoxController do
  use BoxesWeb, :controller

  alias Boxes.Boxes
  alias Boxes.Box

  def index(conn, _params) do
    boxes = Boxes.list_boxes()
    render(conn, "index.html", boxes: boxes)
  end

  def new(conn, _params) do
    changeset = Boxes.change_box(%Box{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"box" => box_params}) do
    case Boxes.create_box(box_params) do
      {:ok, box} ->
        conn
        |> put_flash(:info, "Box created successfully.")
        |> redirect(to: box_path(conn, :show, box))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    box = Boxes.get_box!(id)
    parent_boxes = Boxes.list_parent_boxes(id)
    child_boxes = Boxes.list_child_boxes(id)
    render(conn, "show.html", box: box, parent_boxes: parent_boxes, child_boxes: child_boxes)
  end

  def edit(conn, %{"id" => id}) do
    box = Boxes.get_box!(id)
    changeset = Boxes.change_box(box)
    render(conn, "edit.html", box: box, changeset: changeset)
  end

  def update(conn, %{"id" => id, "box" => box_params}) do
    box = Boxes.get_box!(id)

    case Boxes.update_box(box, box_params) do
      {:ok, box} ->
        conn
        |> put_flash(:info, "Box updated successfully.")
        |> redirect(to: box_path(conn, :show, box))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", box: box, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    box = Boxes.get_box!(id)
    {:ok, _box} = Boxes.delete_box(box)

    conn
    |> put_flash(:info, "Box deleted successfully.")
    |> redirect(to: box_path(conn, :index))
  end
end
