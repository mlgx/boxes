defmodule Boxes.BoxesTest do
  use Boxes.DataCase

  alias Boxes.Boxes

  describe "boxes" do
    alias Boxes.Boxes.Box

    @valid_attrs %{description: "some description", name: "some name", parent: 42}
    @update_attrs %{description: "some updated description", name: "some updated name", parent: 43}
    @invalid_attrs %{description: nil, name: nil, parent: nil}

    def box_fixture(attrs \\ %{}) do
      {:ok, box} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Boxes.create_box()

      box
    end

    test "list_boxes/0 returns all boxes" do
      box = box_fixture()
      assert Boxes.list_boxes() == [box]
    end

    test "get_box!/1 returns the box with given id" do
      box = box_fixture()
      assert Boxes.get_box!(box.id) == box
    end

    test "create_box/1 with valid data creates a box" do
      assert {:ok, %Box{} = box} = Boxes.create_box(@valid_attrs)
      assert box.description == "some description"
      assert box.name == "some name"
      assert box.parent == 42
    end

    test "create_box/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Boxes.create_box(@invalid_attrs)
    end

    test "update_box/2 with valid data updates the box" do
      box = box_fixture()
      assert {:ok, box} = Boxes.update_box(box, @update_attrs)
      assert %Box{} = box
      assert box.description == "some updated description"
      assert box.name == "some updated name"
      assert box.parent == 43
    end

    test "update_box/2 with invalid data returns error changeset" do
      box = box_fixture()
      assert {:error, %Ecto.Changeset{}} = Boxes.update_box(box, @invalid_attrs)
      assert box == Boxes.get_box!(box.id)
    end

    test "delete_box/1 deletes the box" do
      box = box_fixture()
      assert {:ok, %Box{}} = Boxes.delete_box(box)
      assert_raise Ecto.NoResultsError, fn -> Boxes.get_box!(box.id) end
    end

    test "change_box/1 returns a box changeset" do
      box = box_fixture()
      assert %Ecto.Changeset{} = Boxes.change_box(box)
    end
  end
end
