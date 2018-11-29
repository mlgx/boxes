defmodule Boxes.BoxesTest do
  use Boxes.DataCase

  alias Boxes.Boxes

  describe "boxes" do
    alias Boxes.Box

    def box_fixture(attrs \\ %{}) do
      {:ok, box} =
        attrs
        |> Enum.into(%{name: "some name", description: "some description"})
        |> Boxes.create_box()

      box
    end

    # test "list_boxes/0 returns all boxes" do
    #  box = box_fixture()
    #  assert Boxes.list_boxes() == [box]
    # end
    #
    # test "get_box!/1 returns the box with given id" do
    #  box = box_fixture()
    #  assert Boxes.get_box!(box.id) == box
    # end
    #
    test "create_box/1 with valid data creates a box" do
      box = box_fixture()
      assert %Box{} = box
      assert box.name == "some name"
      assert box.description == "some description"
      assert is_nil(box.parent)
    end

    test "create_box/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Boxes.create_box(%{name: nil, description: nil})
    end

    test "create_relationship/1 with valid data adds a relationship to a box" do
      box = box_fixture()
      assert {:ok, rel} = Boxes.create_relationship(%{id: box.id, parent: 1})
      assert rel.id == box.id
      assert rel.parent == 1
    end

    test "create_relationship/1 with non-existing parent raises an exception" do
      # Note: Ideally it should return an error changeset instead of raising an exception.
      box = box_fixture()
      assert_raise Postgrex.Error, fn -> Boxes.create_relationship(%{id: box.id, parent: 0}) end
    end

    test "create_relationship/1 for non-existing box raises and exception" do
      # Note: Ideally it should return an error changeset instead of raising an exception.
      assert_raise Postgrex.Error, fn -> Boxes.create_relationship(%{id: 0, parent: 1}) end
    end

    test "update_box/2 with valid data updates the box" do
      # Create a box.
      box = box_fixture()
      # Update box data (name and description).
      assert {:ok, new_box} = Boxes.update_box(box, %{name: "new name", description: "new desc"})
      assert %Box{} = new_box
      # Check if IDs still match.
      assert box.id == new_box.id
      # Check if the data matches.
      assert new_box.name == "new name"
      assert new_box.description == "new desc"
      assert new_box.parent == nil
      # Fetch the box data from DB.
      db_box = Boxes.get_box!(box.id)
      assert %Box{} = db_box
      # Check if IDs still match.
      assert box.id == new_box.id
      # Check if the data matches.
      assert db_box.name == "new name"
      assert db_box.description == "new desc"
      assert db_box.parent == nil
    end

    # test "update_box/2 with invalid data returns error changeset" do
    #  box = box_fixture()
    #  assert {:error, %Ecto.Changeset{}} = Boxes.update_box(box, @invalid_attrs)
    #  assert box == Boxes.get_box!(box.id)
    # end
    #
    # test "delete_box/1 deletes the box" do
    #  box = box_fixture()
    #  assert {:ok, %Box{}} = Boxes.delete_box(box)
    #  assert_raise Ecto.NoResultsError, fn -> Boxes.get_box!(box.id) end
    # end
    #
    # test "change_box/1 returns a box changeset" do
    #  box = box_fixture()
    #  assert %Ecto.Changeset{} = Boxes.change_box(box)
    # end
  end
end
