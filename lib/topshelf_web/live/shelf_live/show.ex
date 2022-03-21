defmodule TopshelfWeb.ShelfLive.Show do
  use TopshelfWeb, :live_view

  use PetalComponents
  import TopshelfWeb.LiveComponents

  alias Topshelf.Inventory

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:shelf, Inventory.get_shelf!(id))}
  end

  @impl true
  def handle_event("close_modal", _, socket) do
    {:noreply,
     push_patch(socket, to: Routes.shelf_show_path(socket, :index, socket.assigns.shelf))}
  end

  defp page_title(:show), do: "Show Shelf"
  defp page_title(:edit), do: "Edit Shelf"
end
