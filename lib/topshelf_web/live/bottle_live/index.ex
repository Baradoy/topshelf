defmodule TopshelfWeb.BottleLive.Index do
  use TopshelfWeb, :live_view

  use PetalComponents
  import TopshelfWeb.LiveComponents

  alias Topshelf.Inventory
  alias Topshelf.Inventory.Bottle

  alias TopshelfWeb.LandingLive.Search

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:changeset, Search.changeset())
     |> assign_bottles()}
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
    |> assign(:changeset, Search.changeset())
    |> assign_bottles()
  end

  defp apply_action(socket, :shopping, _params) do
    changeset = Search.changeset(%{percent: 20})

    socket
    |> assign(:page_title, "Shopping List")
    |> assign(:bottle, nil)
    |> assign(:changeset, changeset)
    |> assign_bottles()
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    bottle = Inventory.get_bottle!(id)
    {:ok, _} = Inventory.delete_bottle(bottle)

    {:noreply, assign_bottles(socket)}
  end

  def handle_event("empty", %{"id" => id}, socket) do
    bottle = Inventory.get_bottle!(id)
    {:ok, _} = Inventory.update_bottle(bottle, %{remaining_percent: 0})

    {:noreply, assign_bottles(socket)}
  end

  def handle_event("fill", %{"id" => id}, socket) do
    bottle = Inventory.get_bottle!(id)
    {:ok, _} = Inventory.update_bottle(bottle, %{remaining_percent: 100})

    {:noreply, assign_bottles(socket)}
  end

  def handle_event("search", %{"search" => search_params}, socket) do
    changeset = Search.changeset(search_params)

    {:noreply,
     socket
     |> assign(:changeset, changeset)
     |> assign_bottles()}
  end

  def handle_event("close_modal", _, socket) do
    {:noreply, push_patch(socket, to: Routes.bottle_index_path(socket, :index))}
  end

  defp assign_bottles(socket) do
    changes = socket.assigns.changeset.changes

    assign(socket, :bottles, Inventory.list_bottles(changes))
  end
end
