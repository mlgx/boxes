defmodule BoxesWeb.PhysicalRelationshipView do
  use BoxesWeb, :view

  def box_select(physical_boxes) do
    [{"", nil}] |> Enum.concat(physical_boxes |> Enum.map(&{&1.name, &1.id}))
  end
end
