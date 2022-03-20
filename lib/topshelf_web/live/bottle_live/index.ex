defmodule TopshelfWeb.BottleLive.Index do
  use TopshelfWeb, :live_view

  use PetalComponents
  import TopshelfWeb.LiveComponents

  alias Topshelf.Inventory
  alias Topshelf.Inventory.Bottle

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :bottles, list_bottles())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Bottle")
    |> assign(:bottle, Inventory.get_bottle!(id))
    |> assign(:shelves, Inventory.list_shelves())
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Bottle")
    |> assign(:bottle, %Bottle{})
    |> assign(:shelves, Inventory.list_shelves())
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Bottles")
    |> assign(:bottle, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    bottle = Inventory.get_bottle!(id)
    {:ok, _} = Inventory.delete_bottle(bottle)

    {:noreply, assign(socket, :bottles, list_bottles())}
  end

  def handle_event("close_modal", _, socket) do
    {:noreply, push_patch(socket, to: Routes.bottle_index_path(socket, :index))}
  end

  defp list_bottles do
    Inventory.list_bottles()
  end
end
