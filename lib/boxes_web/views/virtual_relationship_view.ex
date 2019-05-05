defmodule BoxesWeb.VirtualRelationshipView do
  use BoxesWeb, :view

  def box_select(virtual_boxes) do
    [{"", nil}] |> Enum.concat(virtual_boxes |> Enum.map(&{&1.name, &1.id}))
  end
end
