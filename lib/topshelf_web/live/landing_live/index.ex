defmodule TopshelfWeb.LandingLive.Index do
  use TopshelfWeb, :live_view

  use PetalComponents
  import TopshelfWeb.LiveComponents

  alias Topshelf.Inventory

  alias TopshelfWeb.LandingLive.Search

  @impl true

  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:bottles, list_bottles())
     |> assign(:changeset, Search.changeset())}
  end

  @impl true
  def handle_event("search", %{"search" => search_params}, socket) do
    changeset = Search.changeset(search_params)

    bottles =
      case changeset do
        %{valid?: true, changes: changes} ->
          Inventory.list_bottles(changes)

        _ ->
          Inventory.list_bottles()
      end

    {:noreply, assign(socket, :bottles, bottles) |> assign(:changeset, changeset)}
  end

  defp list_bottles do
    Inventory.list_bottles()
  end
end
