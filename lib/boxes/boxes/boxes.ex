defmodule Boxes.Boxes do
  @moduledoc """
  The Boxes context.
  """

  import Ecto.Query, warn: false
  alias Boxes.Repo

  alias Boxes.Boxes.Box

  @doc """
  Returns the list of boxes.

  Exclude Physical and Virtual boxes which exist only for internal use.
  Exclude relationships.
  ## Examples

      iex> list_boxes()
      [%Box{}, ...]

  """
  def list_boxes do
    query =
      from(
        b in Box,
        where: b.id not in [1, 2] and is_nil(b.parent),
        select: b
      )

    Repo.all(query)
  end

  def list_parent_boxes(id) do
    query =
      from(
        b in Box,
        where: b.id not in [1, 2] and is_nil(b.parent),
        join: r in Box,
        where: r.id == ^id and is_nil(r.name),
        where: b.id == r.parent,
        select: b
      )

    Repo.all(query)
  end

  def list_child_boxes(id) do
    query =
      from(
        b in Box,
        where: b.id not in [1, 2] and is_nil(b.parent),
        join: r in Box,
        where: r.parent == ^id and is_nil(r.name),
        where: b.id == r.id,
        select: b
      )

    Repo.all(query)
  end

  @doc """
  Gets a single box.

  We can't do a simple Repo.get!/2 because there's no primary key.

  Raises `Ecto.NoResultsError` if the Box does not exist.

  ## Examples

      iex> get_box!(123)
      %Box{}

      iex> get_box!(456)
      ** (Ecto.NoResultsError)

  """
  def get_box!(id) do
    query =
      from(
        b in Box,
        where: b.id == ^id and is_nil(b.parent),
        select: %{
          b
          | virtual:
              fragment(
                "(SELECT COUNT(id) > 0 AS virtual FROM boxes WHERE id = ? and parent = 2)",
                b.id
              )
        }
      )

    Repo.one!(query)
  end

  @doc """
  Creates a box.

  ## Examples

      iex> create_box(%{field: value})
      {:ok, %Box{}}

      iex> create_box(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_box(attrs \\ %{}) do
    %Box{}
    |> Box.create_box_changeset(attrs)
    |> Repo.insert()
  end

  def create_relationship(attrs \\ %{}) do
    %Box{}
    |> Box.create_relationship_changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a box.

  We can't do a simple Repo.update/2 because there's no primary key.
  ## Examples

      iex> update_box(box, %{field: new_value})
      {:ok, %Box{}}

      iex> update_box(box, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_box(%Box{} = box, attrs) do
    import Ecto.Changeset

    # Create the changeset.
    changeset = box |> Box.update_box_changeset(attrs)

    # Apply the changeset.
    {:ok, new_box} = changeset |> apply_action(:update)

    # Update box with new_box data.
    # Note: We must do an update_all because there's no primary key on the table.
    #       We use the combination of "box ID" + "parent IS NULL" which is unique.
    {number_rows_updated, nil} =
      from(b in Box, where: b.id == ^box.id and is_nil(b.parent))
      |> Repo.update_all(set: [name: new_box.name, description: new_box.description])

    # Optionally:
    # To be extra sure that the update worked we pull the data from DB.
    # new_box = get_box!(Box, box.id)

    # Confirm that we only updated one row.
    case number_rows_updated do
      1 -> {:ok, new_box}
      _ -> {:error, changeset}
    end
  end

  @doc """
  Deletes a Box.

  ## Examples

      iex> delete_box(box)
      {:ok, %Box{}}

      iex> delete_box(box)
      {:error, %Ecto.Changeset{}}

  """
  def delete_box(%Box{} = box) do
    Repo.delete(box)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking box changes.

  ## Examples

      iex> change_box(box)
      %Ecto.Changeset{source: %Box{}}

  """
  def change_box(%Box{} = box) do
    Box.changeset(box, %{})
  end
end
