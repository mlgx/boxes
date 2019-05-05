defmodule BoxesWeb.Router do
  use BoxesWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", BoxesWeb do
    # Use the default browser stack
    pipe_through(:browser)

    get("/", PageController, :index)

    resources("/physical_boxes", PhysicalBoxController)
    resources("/physical_boxes_relationships", PhysicalRelationshipController)
    resources("/virtual_boxes", VirtualBoxController)
    resources("/virtual_boxes_relationships", VirtualRelationshipController)
  end

  # Other scopes may use custom stacks.
  # scope "/api", BoxesWeb do
  #   pipe_through :api
  # end
end
