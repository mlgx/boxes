defmodule BoxesWeb.PhysicalBoxControllerTest do
  use BoxesWeb.ConnCase

  alias Boxes.Physical

  @create_attrs %{description: "some description", name: "some name"}
  @update_attrs %{description: "some updated description", name: "some updated name"}
  @invalid_attrs %{description: nil, name: nil}

  def fixture(:physical_box) do
    {:ok, physical_box} = Physical.create_physical_box(@create_attrs)
    physical_box
  end

#  describe "index" do
#    test "lists all physical_boxes", %{conn: conn} do
#      conn = get conn, physical_box_path(conn, :index)
#      assert html_response(conn, 200) =~ "Listing Physical boxes"
#    end
#  end
#
#  describe "new physical_box" do
#    test "renders form", %{conn: conn} do
#      conn = get conn, physical_box_path(conn, :new)
#      assert html_response(conn, 200) =~ "New Physical box"
#    end
#  end
#
#  describe "create physical_box" do
#    test "redirects to show when data is valid", %{conn: conn} do
#      conn = post conn, physical_box_path(conn, :create), physical_box: @create_attrs
#
#      assert %{id: id} = redirected_params(conn)
#      assert redirected_to(conn) == physical_box_path(conn, :show, id)
#
#      conn = get conn, physical_box_path(conn, :show, id)
#      assert html_response(conn, 200) =~ "Show Physical box"
#    end
#
#    test "renders errors when data is invalid", %{conn: conn} do
#      conn = post conn, physical_box_path(conn, :create), physical_box: @invalid_attrs
#      assert html_response(conn, 200) =~ "New Physical box"
#    end
#  end
#
#  describe "edit physical_box" do
#    setup [:create_physical_box]
#
#    test "renders form for editing chosen physical_box", %{conn: conn, physical_box: physical_box} do
#      conn = get conn, physical_box_path(conn, :edit, physical_box)
#      assert html_response(conn, 200) =~ "Edit Physical box"
#    end
#  end
#
#  describe "update physical_box" do
#    setup [:create_physical_box]
#
#    test "redirects when data is valid", %{conn: conn, physical_box: physical_box} do
#      conn = put conn, physical_box_path(conn, :update, physical_box), physical_box: @update_attrs
#      assert redirected_to(conn) == physical_box_path(conn, :show, physical_box)
#
#      conn = get conn, physical_box_path(conn, :show, physical_box)
#      assert html_response(conn, 200) =~ "some updated description"
#    end
#
#    test "renders errors when data is invalid", %{conn: conn, physical_box: physical_box} do
#      conn = put conn, physical_box_path(conn, :update, physical_box), physical_box: @invalid_attrs
#      assert html_response(conn, 200) =~ "Edit Physical box"
#    end
#  end
#
#  describe "delete physical_box" do
#    setup [:create_physical_box]
#
#    test "deletes chosen physical_box", %{conn: conn, physical_box: physical_box} do
#      conn = delete conn, physical_box_path(conn, :delete, physical_box)
#      assert redirected_to(conn) == physical_box_path(conn, :index)
#      assert_error_sent 404, fn ->
#        get conn, physical_box_path(conn, :show, physical_box)
#      end
#    end
#  end

  defp create_physical_box(_) do
    physical_box = fixture(:physical_box)
    {:ok, physical_box: physical_box}
  end
end
