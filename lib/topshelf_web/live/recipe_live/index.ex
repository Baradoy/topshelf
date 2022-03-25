defmodule TopshelfWeb.RecipeLive.Index do
  use TopshelfWeb, :live_view

  use PetalComponents
  import TopshelfWeb.LiveComponents

  alias Topshelf.Inventory
  alias Topshelf.Cocktails
  alias Topshelf.Cocktails.Recipe

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:recipes, list_recipes())
     |> assign(:bottles, list_bottles())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Recipe")
    |> assign(:recipe, Cocktails.get_recipe!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Recipe")
    |> assign(:recipe, %Recipe{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Recipes")
    |> assign(:recipe, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    recipe = Cocktails.get_recipe!(id)
    {:ok, _} = Cocktails.delete_recipe(recipe)

    {:noreply, assign(socket, :recipes, list_recipes())}
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

  def handle_event("close_modal", _, socket) do
    {:noreply, push_patch(socket, to: Routes.recipe_index_path(socket, :index))}
  end

  defp list_recipes do
    Cocktails.list_recipes()
  end

  defp list_bottles do
    Inventory.list_bottles()
  end
end
