defmodule BoxesWeb.BoxControllerTest do
  use BoxesWeb.ConnCase

  alias Boxes.Boxes

  @create_attrs %{description: "some description", name: "some name", parent: 42}
  @update_attrs %{description: "some updated description", name: "some updated name", parent: 43}
  @invalid_attrs %{description: nil, name: nil, parent: nil}

  def fixture(:box) do
    {:ok, box} = Boxes.create_box(@create_attrs)
    box
  end

  describe "index" do
    test "lists all boxes", %{conn: conn} do
      conn = get conn, box_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Boxes"
    end
  end

  describe "new box" do
    test "renders form", %{conn: conn} do
      conn = get conn, box_path(conn, :new)
      assert html_response(conn, 200) =~ "New Box"
    end
  end

  describe "create box" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, box_path(conn, :create), box: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == box_path(conn, :show, id)

      conn = get conn, box_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Box"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, box_path(conn, :create), box: @invalid_attrs
      assert html_response(conn, 200) =~ "New Box"
    end
  end

  describe "edit box" do
    setup [:create_box]

    test "renders form for editing chosen box", %{conn: conn, box: box} do
      conn = get conn, box_path(conn, :edit, box)
      assert html_response(conn, 200) =~ "Edit Box"
    end
  end

  describe "update box" do
    setup [:create_box]

    test "redirects when data is valid", %{conn: conn, box: box} do
      conn = put conn, box_path(conn, :update, box), box: @update_attrs
      assert redirected_to(conn) == box_path(conn, :show, box)

      conn = get conn, box_path(conn, :show, box)
      assert html_response(conn, 200) =~ "some updated description"
    end

    test "renders errors when data is invalid", %{conn: conn, box: box} do
      conn = put conn, box_path(conn, :update, box), box: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Box"
    end
  end

  describe "delete box" do
    setup [:create_box]

    test "deletes chosen box", %{conn: conn, box: box} do
      conn = delete conn, box_path(conn, :delete, box)
      assert redirected_to(conn) == box_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, box_path(conn, :show, box)
      end
    end
  end

  defp create_box(_) do
    box = fixture(:box)
    {:ok, box: box}
  end
end
