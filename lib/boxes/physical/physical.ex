defmodule Boxes.Physical do
  @moduledoc """
  The Physical context.
  """

  import Ecto.Query, warn: false
  alias Boxes.Repo

  alias Boxes.Physical.PhysicalRelationship

  @doc """
  Returns the list of physical_boxes_relationships.

  ## Examples

      iex> list_physical_boxes_relationships()
      [%PhysicalRelationship{}, ...]

  """
  def list_physical_boxes_relationships do
    Repo.all(PhysicalRelationship)
  end

  @doc """
  Gets a single physical_relationship.

  Raises `Ecto.NoResultsError` if the Physical relationship does not exist.

  ## Examples

      iex> get_physical_relationship!(123)
      %PhysicalRelationship{}

      iex> get_physical_relationship!(456)
      ** (Ecto.NoResultsError)

  """
  def get_physical_relationship!(id), do: Repo.get!(PhysicalRelationship, id)

  @doc """
  Creates a physical_relationship.

  ## Examples

      iex> create_physical_relationship(%{field: value})
      {:ok, %PhysicalRelationship{}}

      iex> create_physical_relationship(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_physical_relationship(attrs \\ %{}) do
    %PhysicalRelationship{}
    |> PhysicalRelationship.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a physical_relationship.

  ## Examples

      iex> update_physical_relationship(physical_relationship, %{field: new_value})
      {:ok, %PhysicalRelationship{}}

      iex> update_physical_relationship(physical_relationship, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_physical_relationship(%PhysicalRelationship{} = physical_relationship, attrs) do
    physical_relationship
    |> PhysicalRelationship.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a PhysicalRelationship.

  ## Examples

      iex> delete_physical_relationship(physical_relationship)
      {:ok, %PhysicalRelationship{}}

      iex> delete_physical_relationship(physical_relationship)
      {:error, %Ecto.Changeset{}}

  """
  def delete_physical_relationship(%PhysicalRelationship{} = physical_relationship) do
    Repo.delete(physical_relationship)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking physical_relationship changes.

  ## Examples

      iex> change_physical_relationship(physical_relationship)
      %Ecto.Changeset{source: %PhysicalRelationship{}}

  """
  def change_physical_relationship(%PhysicalRelationship{} = physical_relationship) do
    PhysicalRelationship.changeset(physical_relationship, %{})
  end

  alias Boxes.Physical.PhysicalBox

  @doc """
  Returns the list of physical_boxes.

  ## Examples

      iex> list_physical_boxes()
      [%PhysicalBox{}, ...]

  """
  def list_physical_boxes do
    Repo.all(PhysicalBox)
  end

  @doc """
  Gets a single physical_box.

  Raises `Ecto.NoResultsError` if the Physical box does not exist.

  ## Examples

      iex> get_physical_box!(123)
      %PhysicalBox{}

      iex> get_physical_box!(456)
      ** (Ecto.NoResultsError)

  """
  def get_physical_box!(id), do: Repo.get!(PhysicalBox, id)

  @doc """
  Creates a physical_box.

  ## Examples

      iex> create_physical_box(%{field: value})
      {:ok, %PhysicalBox{}}

      iex> create_physical_box(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_physical_box(attrs \\ %{}) do
    %PhysicalBox{}
    |> PhysicalBox.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a physical_box.

  ## Examples

      iex> update_physical_box(physical_box, %{field: new_value})
      {:ok, %PhysicalBox{}}

      iex> update_physical_box(physical_box, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_physical_box(%PhysicalBox{} = physical_box, attrs) do
    physical_box
    |> PhysicalBox.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a PhysicalBox.

  ## Examples

      iex> delete_physical_box(physical_box)
      {:ok, %PhysicalBox{}}

      iex> delete_physical_box(physical_box)
      {:error, %Ecto.Changeset{}}

  """
  def delete_physical_box(%PhysicalBox{} = physical_box) do
    Repo.delete(physical_box)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking physical_box changes.

  ## Examples

      iex> change_physical_box(physical_box)
      %Ecto.Changeset{source: %PhysicalBox{}}

  """
  def change_physical_box(%PhysicalBox{} = physical_box) do
    PhysicalBox.changeset(physical_box, %{})
  end
end
