defmodule TopshelfWeb.ShelfLive.Index do
  use TopshelfWeb, :live_view

  use PetalComponents
  import TopshelfWeb.LiveComponents

  alias Topshelf.Inventory
  alias Topshelf.Inventory.Shelf

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :shelves, list_shelves())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Shelf")
    |> assign(:shelf, Inventory.get_shelf!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Shelf")
    |> assign(:shelf, %Shelf{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Shelves")
    |> assign(:shelf, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    shelf = Inventory.get_shelf!(id)
    {:ok, _} = Inventory.delete_shelf(shelf)

    {:noreply, assign(socket, :shelves, list_shelves())}
  end

  def handle_event("close_modal", _, socket) do
    {:noreply, push_patch(socket, to: Routes.shelf_index_path(socket, :index))}
  end

  defp list_shelves do
    Inventory.list_shelves()
  end
end
