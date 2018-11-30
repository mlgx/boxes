defmodule BoxesWeb.PhysicalRelationshipControllerTest do
  use BoxesWeb.ConnCase

  alias Boxes.Physical

  @create_attrs %{id: 42, parent_id: 42}
  @update_attrs %{id: 43, parent_id: 43}
  @invalid_attrs %{id: nil, parent_id: nil}

  def fixture(:physical_relationship) do
    {:ok, physical_relationship} = Physical.create_physical_relationship(@create_attrs)
    physical_relationship
  end

#  describe "index" do
#    test "lists all physical_boxes_relationships", %{conn: conn} do
#      conn = get conn, physical_relationship_path(conn, :index)
#      assert html_response(conn, 200) =~ "Listing Physical boxes relationships"
#    end
#  end
#
#  describe "new physical_relationship" do
#    test "renders form", %{conn: conn} do
#      conn = get conn, physical_relationship_path(conn, :new)
#      assert html_response(conn, 200) =~ "New Physical relationship"
#    end
#  end
#
#  describe "create physical_relationship" do
#    test "redirects to show when data is valid", %{conn: conn} do
#      conn = post conn, physical_relationship_path(conn, :create), physical_relationship: @create_attrs
#
#      assert %{id: id} = redirected_params(conn)
#      assert redirected_to(conn) == physical_relationship_path(conn, :show, id)
#
#      conn = get conn, physical_relationship_path(conn, :show, id)
#      assert html_response(conn, 200) =~ "Show Physical relationship"
#    end
#
#    test "renders errors when data is invalid", %{conn: conn} do
#      conn = post conn, physical_relationship_path(conn, :create), physical_relationship: @invalid_attrs
#      assert html_response(conn, 200) =~ "New Physical relationship"
#    end
#  end
#
#  describe "edit physical_relationship" do
#    setup [:create_physical_relationship]
#
#    test "renders form for editing chosen physical_relationship", %{conn: conn, physical_relationship: physical_relationship} do
#      conn = get conn, physical_relationship_path(conn, :edit, physical_relationship)
#      assert html_response(conn, 200) =~ "Edit Physical relationship"
#    end
#  end
#
#  describe "update physical_relationship" do
#    setup [:create_physical_relationship]
#
#    test "redirects when data is valid", %{conn: conn, physical_relationship: physical_relationship} do
#      conn = put conn, physical_relationship_path(conn, :update, physical_relationship), physical_relationship: @update_attrs
#      assert redirected_to(conn) == physical_relationship_path(conn, :show, physical_relationship)
#
#      conn = get conn, physical_relationship_path(conn, :show, physical_relationship)
#      assert html_response(conn, 200)
#    end
#
#    test "renders errors when data is invalid", %{conn: conn, physical_relationship: physical_relationship} do
#      conn = put conn, physical_relationship_path(conn, :update, physical_relationship), physical_relationship: @invalid_attrs
#      assert html_response(conn, 200) =~ "Edit Physical relationship"
#    end
#  end
#
#  describe "delete physical_relationship" do
#    setup [:create_physical_relationship]
#
#    test "deletes chosen physical_relationship", %{conn: conn, physical_relationship: physical_relationship} do
#      conn = delete conn, physical_relationship_path(conn, :delete, physical_relationship)
#      assert redirected_to(conn) == physical_relationship_path(conn, :index)
#      assert_error_sent 404, fn ->
#        get conn, physical_relationship_path(conn, :show, physical_relationship)
#      end
#    end
#  end

  defp create_physical_relationship(_) do
    physical_relationship = fixture(:physical_relationship)
    {:ok, physical_relationship: physical_relationship}
  end
end
