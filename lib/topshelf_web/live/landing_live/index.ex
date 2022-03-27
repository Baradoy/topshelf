defmodule TopshelfWeb.LandingLive.Index do
  use TopshelfWeb, :live_view

  use PetalComponents
  import TopshelfWeb.LiveComponents

  alias Topshelf.Cocktails
  alias TopshelfWeb.RecipeLive.RecipeComponent

  @impl true

  def mount(_params, _session, socket) do
    {:ok, assign(socket, :recipes, list_recipes())}
  end

  @impl true
  def handle_event("pour_cocktail", %{"value" => id}, socket) do
    recipe = Cocktails.get_recipe!(id)
    {:ok, _} = Cocktails.pour_recipe(recipe)

    socket =
      socket
      |> put_flash(:info, "Poured a #{recipe.name}. Bottles have been updated.")
      |> assign(:recipes, list_recipes())

    {:noreply, socket}
  end

  defp list_recipes do
    Cocktails.list_recipes()
  end
end
