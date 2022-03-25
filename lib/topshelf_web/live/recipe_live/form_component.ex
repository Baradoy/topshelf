defmodule TopshelfWeb.RecipeLive.FormComponent do
  use TopshelfWeb, :live_component

  use PetalComponents

  alias Topshelf.Cocktails

  @impl true
  def update(%{recipe: recipe} = assigns, socket) do
    changeset = Cocktails.recipe_changeset(recipe)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("add_ingredient", _params, socket) do
    changeset = Cocktails.recipe_add_ingredient_changeset(socket.assigns.changeset)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  @impl true
  def handle_event("remove_ingredient", %{"value" => index}, socket) do
    {index, ""} = Integer.parse(index)
    changeset = Cocktails.recipe_remove_ingredient_changeset(socket.assigns.changeset, index)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("validate", %{"recipe" => recipe_params}, socket) do
    changeset =
      socket.assigns.recipe
      |> Cocktails.recipe_changeset(recipe_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"recipe" => recipe_params}, socket) do
    save_recipe(socket, socket.assigns.action, recipe_params)
  end

  defp save_recipe(socket, :edit, recipe_params) do
    case Cocktails.update_recipe(socket.assigns.recipe, recipe_params) do
      {:ok, _recipe} ->
        {:noreply,
         socket
         |> put_flash(:info, "Recipe updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_recipe(socket, :new, recipe_params) do
    case Cocktails.create_recipe(recipe_params) do
      {:ok, _recipe} ->
        {:noreply,
         socket
         |> put_flash(:info, "Recipe created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
