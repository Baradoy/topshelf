defmodule TopshelfWeb.ShelfLive.FormComponent do
  use TopshelfWeb, :live_component

  use PetalComponents

  alias Topshelf.Inventory

  @impl true
  def update(%{shelf: shelf} = assigns, socket) do
    changeset = Inventory.change_shelf(shelf)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"shelf" => shelf_params}, socket) do
    changeset =
      socket.assigns.shelf
      |> Inventory.change_shelf(shelf_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"shelf" => shelf_params}, socket) do
    save_shelf(socket, socket.assigns.action, shelf_params)
  end

  defp save_shelf(socket, :edit, shelf_params) do
    case Inventory.update_shelf(socket.assigns.shelf, shelf_params) do
      {:ok, _shelf} ->
        {:noreply,
         socket
         |> put_flash(:info, "Shelf updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_shelf(socket, :new, shelf_params) do
    case Inventory.create_shelf(shelf_params) do
      {:ok, _shelf} ->
        {:noreply,
         socket
         |> put_flash(:info, "Shelf created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
