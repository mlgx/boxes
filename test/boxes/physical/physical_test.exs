defmodule Boxes.PhysicalTest do
  use Boxes.DataCase

  alias Boxes.Physical

  describe "physical_boxes_relationships" do
    alias Boxes.Physical.PhysicalRelationship

    @valid_attrs %{id: 42, parent_id: 42}
    @update_attrs %{id: 43, parent_id: 43}
    @invalid_attrs %{id: nil, parent_id: nil}

    def physical_relationship_fixture(attrs \\ %{}) do
      {:ok, physical_relationship} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Physical.create_physical_relationship()

      physical_relationship
    end

    test "list_physical_boxes_relationships/0 returns all physical_boxes_relationships" do
      physical_relationship = physical_relationship_fixture()
      assert Physical.list_physical_boxes_relationships() == [physical_relationship]
    end

    test "get_physical_relationship!/1 returns the physical_relationship with given id" do
      physical_relationship = physical_relationship_fixture()
      assert Physical.get_physical_relationship!(physical_relationship.id) == physical_relationship
    end

    test "create_physical_relationship/1 with valid data creates a physical_relationship" do
      assert {:ok, %PhysicalRelationship{} = physical_relationship} = Physical.create_physical_relationship(@valid_attrs)
      assert physical_relationship.id == 42
      assert physical_relationship.parent_id == 42
    end

    test "create_physical_relationship/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Physical.create_physical_relationship(@invalid_attrs)
    end

    test "update_physical_relationship/2 with valid data updates the physical_relationship" do
      physical_relationship = physical_relationship_fixture()
      assert {:ok, physical_relationship} = Physical.update_physical_relationship(physical_relationship, @update_attrs)
      assert %PhysicalRelationship{} = physical_relationship
      assert physical_relationship.id == 43
      assert physical_relationship.parent_id == 43
    end

    test "update_physical_relationship/2 with invalid data returns error changeset" do
      physical_relationship = physical_relationship_fixture()
      assert {:error, %Ecto.Changeset{}} = Physical.update_physical_relationship(physical_relationship, @invalid_attrs)
      assert physical_relationship == Physical.get_physical_relationship!(physical_relationship.id)
    end

    test "delete_physical_relationship/1 deletes the physical_relationship" do
      physical_relationship = physical_relationship_fixture()
      assert {:ok, %PhysicalRelationship{}} = Physical.delete_physical_relationship(physical_relationship)
      assert_raise Ecto.NoResultsError, fn -> Physical.get_physical_relationship!(physical_relationship.id) end
    end

    test "change_physical_relationship/1 returns a physical_relationship changeset" do
      physical_relationship = physical_relationship_fixture()
      assert %Ecto.Changeset{} = Physical.change_physical_relationship(physical_relationship)
    end
  end

  describe "physical_boxes" do
    alias Boxes.Physical.PhysicalBox

    @valid_attrs %{description: "some description", name: "some name"}
    @update_attrs %{description: "some updated description", name: "some updated name"}
    @invalid_attrs %{description: nil, name: nil}

    def physical_box_fixture(attrs \\ %{}) do
      {:ok, physical_box} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Physical.create_physical_box()

      physical_box
    end

    test "list_physical_boxes/0 returns all physical_boxes" do
      physical_box = physical_box_fixture()
      assert Physical.list_physical_boxes() == [physical_box]
    end

    test "get_physical_box!/1 returns the physical_box with given id" do
      physical_box = physical_box_fixture()
      assert Physical.get_physical_box!(physical_box.id) == physical_box
    end

    test "create_physical_box/1 with valid data creates a physical_box" do
      assert {:ok, %PhysicalBox{} = physical_box} = Physical.create_physical_box(@valid_attrs)
      assert physical_box.description == "some description"
      assert physical_box.name == "some name"
    end

    test "create_physical_box/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Physical.create_physical_box(@invalid_attrs)
    end

    test "update_physical_box/2 with valid data updates the physical_box" do
      physical_box = physical_box_fixture()
      assert {:ok, physical_box} = Physical.update_physical_box(physical_box, @update_attrs)
      assert %PhysicalBox{} = physical_box
      assert physical_box.description == "some updated description"
      assert physical_box.name == "some updated name"
    end

    test "update_physical_box/2 with invalid data returns error changeset" do
      physical_box = physical_box_fixture()
      assert {:error, %Ecto.Changeset{}} = Physical.update_physical_box(physical_box, @invalid_attrs)
      assert physical_box == Physical.get_physical_box!(physical_box.id)
    end

    test "delete_physical_box/1 deletes the physical_box" do
      physical_box = physical_box_fixture()
      assert {:ok, %PhysicalBox{}} = Physical.delete_physical_box(physical_box)
      assert_raise Ecto.NoResultsError, fn -> Physical.get_physical_box!(physical_box.id) end
    end

    test "change_physical_box/1 returns a physical_box changeset" do
      physical_box = physical_box_fixture()
      assert %Ecto.Changeset{} = Physical.change_physical_box(physical_box)
    end
  end
end
