defmodule Boxes.Virtual do
  @moduledoc """
  The Virtual context.
  """

  import Ecto.Query, warn: false
  alias Boxes.Repo

  alias Boxes.Virtual.VirtualBox

  @doc """
  Returns the list of virtual_boxes.

  ## Examples

      iex> list_virtual_boxes()
      [%VirtualBox{}, ...]

  """
  def list_virtual_boxes do
    Repo.all(VirtualBox)
  end

  @doc """
  Gets a single virtual_box.

  Raises `Ecto.NoResultsError` if the Virtual box does not exist.

  ## Examples

      iex> get_virtual_box!(123)
      %VirtualBox{}

      iex> get_virtual_box!(456)
      ** (Ecto.NoResultsError)

  """
  def get_virtual_box!(id) do
    query =
      from(b in VirtualBox,
        where: b.id == ^id,
        select: b,
        preload: [:virtual_parent, :virtual_children]
      )

    Repo.one!(query)
  end

  @doc """
  Creates a virtual_box.

  ## Examples

      iex> create_virtual_box(%{field: value})
      {:ok, %VirtualBox{}}

      iex> create_virtual_box(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_virtual_box(attrs \\ %{}) do
    %VirtualBox{}
    |> VirtualBox.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a virtual_box.

  ## Examples

      iex> update_virtual_box(virtual_box, %{field: new_value})
      {:ok, %VirtualBox{}}

      iex> update_virtual_box(virtual_box, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_virtual_box(%VirtualBox{} = virtual_box, attrs) do
    virtual_box
    |> VirtualBox.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a VirtualBox.

  ## Examples

      iex> delete_virtual_box(virtual_box)
      {:ok, %VirtualBox{}}

      iex> delete_virtual_box(virtual_box)
      {:error, %Ecto.Changeset{}}

  """
  def delete_virtual_box(%VirtualBox{} = virtual_box) do
    Repo.delete(virtual_box)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking virtual_box changes.

  ## Examples

      iex> change_virtual_box(virtual_box)
      %Ecto.Changeset{source: %VirtualBox{}}

  """
  def change_virtual_box(%VirtualBox{} = virtual_box) do
    VirtualBox.changeset(virtual_box, %{})
  end

  alias Boxes.Virtual.VirtualRelationship

  @doc """
  Returns the list of virtual_boxes_relationships.

  ## Examples

      iex> list_virtual_boxes_relationships()
      [%VirtualRelationship{}, ...]

  """
  def list_virtual_boxes_relationships do
    Repo.all(VirtualRelationship)
  end

  @doc """
  Gets a single virtual_relationship.

  Raises `Ecto.NoResultsError` if the Virtual relationship does not exist.

  ## Examples

      iex> get_virtual_relationship!(123)
      %VirtualRelationship{}

      iex> get_virtual_relationship!(456)
      ** (Ecto.NoResultsError)

  """
  def get_virtual_relationship!(id) do
    query =
      from(r in VirtualRelationship,
        where: r.id == ^id,
        select: r,
        preload: [:box, :parent]
      )

    Repo.one!(query)
  end

  @doc """
  Creates a virtual_relationship.

  ## Examples

      iex> create_virtual_relationship(%{field: value})
      {:ok, %VirtualRelationship{}}

      iex> create_virtual_relationship(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_virtual_relationship(attrs \\ %{}) do
    %VirtualRelationship{}
    |> VirtualRelationship.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a virtual_relationship.

  ## Examples

      iex> update_virtual_relationship(virtual_relationship, %{field: new_value})
      {:ok, %VirtualRelationship{}}

      iex> update_virtual_relationship(virtual_relationship, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_virtual_relationship(%VirtualRelationship{} = virtual_relationship, attrs) do
    virtual_relationship
    |> VirtualRelationship.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a VirtualRelationship.

  ## Examples

      iex> delete_virtual_relationship(virtual_relationship)
      {:ok, %VirtualRelationship{}}

      iex> delete_virtual_relationship(virtual_relationship)
      {:error, %Ecto.Changeset{}}

  """
  def delete_virtual_relationship(%VirtualRelationship{} = virtual_relationship) do
    Repo.delete(virtual_relationship)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking virtual_relationship changes.

  ## Examples

      iex> change_virtual_relationship(virtual_relationship)
      %Ecto.Changeset{source: %VirtualRelationship{}}

  """
  def change_virtual_relationship(%VirtualRelationship{} = virtual_relationship) do
    VirtualRelationship.changeset(virtual_relationship, %{})
  end
end
