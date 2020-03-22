defmodule Boxes.Physical do
  @moduledoc """
  The Physical context.
  """

  import Ecto.Query, warn: false
  alias Boxes.Repo

  defp apply_params(query, params) do
    from(q in query)
    |> apply_preload(params[:preload])
  end

  defp apply_preload(query, nil), do: query

  defp apply_preload(query, params) do
    from(q in query,
      preload: ^params
    )
  end

  alias Boxes.Physical.PhysicalBox

  @doc """
  Returns the list of physical_boxes.

  ## Examples

      iex> list_physical_boxes()
      [%PhysicalBox{}, ...]

  """
  def list_physical_boxes(params \\ %{}) do
    from(b in PhysicalBox)
    |> apply_params(params)
    |> Repo.all()
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
  def get_physical_box!(id, params \\ %{}) do
    from(b in PhysicalBox,
      where: b.id == ^id,
      select: b
    )
    |> apply_params(params)
    |> Repo.one!()
  end

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

  alias Boxes.Physical.PhysicalRelationship

  @doc """
  Returns the list of physical_boxes_relationships.

  ## Examples

      iex> list_physical_boxes_relationships()
      [%PhysicalRelationship{}, ...]

  """
  def list_physical_boxes_relationships(params \\ %{}) do
    from(r in PhysicalRelationship)
    |> apply_params(params)
    |> Repo.all()
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
  def get_physical_relationship!(id, params \\ %{}) do
    from(r in PhysicalRelationship,
      where: r.id == ^id,
      select: r
    )
    |> apply_params(params)
    |> Repo.one!()
  end

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
end
