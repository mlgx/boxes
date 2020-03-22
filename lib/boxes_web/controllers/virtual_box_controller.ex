defmodule BoxesWeb.VirtualBoxController do
  use BoxesWeb, :controller

  import Phoenix.HTML.Link

  alias Boxes.Virtual
  alias Boxes.Virtual.VirtualBox

  def index(conn, _params) do
    virtual_boxes = Virtual.list_virtual_boxes()
    render(conn, "index.html", virtual_boxes: virtual_boxes)
  end

  def new(conn, _params) do
    changeset = Virtual.change_virtual_box(%VirtualBox{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"virtual_box" => virtual_box_params}) do
    case Virtual.create_virtual_box(virtual_box_params) do
      {:ok, virtual_box} ->
        conn
        |> put_flash(:info, ["Virtual box created successfully.", link("Create new one?", to: Routes.virtual_box_path(conn, :new))])
        |> redirect(to: Routes.virtual_box_path(conn, :show, virtual_box))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    virtual_box = Virtual.get_virtual_box!(id, %{preload: [:virtual_parent, :virtual_children]})
    render(conn, "show.html", virtual_box: virtual_box)
  end

  def edit(conn, %{"id" => id}) do
    virtual_box = Virtual.get_virtual_box!(id)
    changeset = Virtual.change_virtual_box(virtual_box)
    render(conn, "edit.html", virtual_box: virtual_box, changeset: changeset)
  end

  def update(conn, %{"id" => id, "virtual_box" => virtual_box_params}) do
    virtual_box = Virtual.get_virtual_box!(id)

    case Virtual.update_virtual_box(virtual_box, virtual_box_params) do
      {:ok, virtual_box} ->
        conn
        |> put_flash(:info, "Virtual box updated successfully.")
        |> redirect(to: Routes.virtual_box_path(conn, :show, virtual_box))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", virtual_box: virtual_box, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    virtual_box = Virtual.get_virtual_box!(id)
    {:ok, _virtual_box} = Virtual.delete_virtual_box(virtual_box)

    conn
    |> put_flash(:info, "Virtual box deleted successfully.")
    |> redirect(to: Routes.virtual_box_path(conn, :index))
  end
end
