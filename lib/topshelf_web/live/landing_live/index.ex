defmodule TopshelfWeb.LandingLive.Index do
  use TopshelfWeb, :live_view

  use PetalComponents
  import TopshelfWeb.LiveComponents

  alias Topshelf.Inventory
  alias Topshelf.Cocktails

  alias TopshelfWeb.LandingLive.Search
  alias TopshelfWeb.RecipeLive.RecipeComponent

  @impl true

  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:bottles, list_bottles())
     |> assign(:recipes, list_recipes())
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

  def handle_event("pour_cocktail", %{"value" => id}, socket) do
    recipe = Cocktails.get_recipe!(id)
    {:ok, _} = Cocktails.pour_recipe(recipe)

    socket =
      socket
      |> put_flash(:info, "Poured a #{recipe.name}. Bottles have been updated.")
      |> assign(:recipes, list_recipes())
      |> assign(:bottles, list_bottles())

    {:noreply, socket}
  end

  defp list_bottles do
    Inventory.list_bottles()
  end

  defp list_recipes do
    Cocktails.list_recipes()
  end
end
