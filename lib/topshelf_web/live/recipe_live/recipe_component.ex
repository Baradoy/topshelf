defmodule TopshelfWeb.RecipeLive.RecipeComponent do
  use TopshelfWeb, :live_component

  use PetalComponents
  @impl true
  def update(%{recipe: recipe} = assigns, socket) do
    socket = socket |> assign(assigns)
    {:ok, socket}
  end

  def progress_color(remaining_percent) do
    case remaining_percent do
      percent when percent <= 0 -> "danger"
      percent when percent <= 33 -> "warning"
      _ -> "primary"
    end
  end
end
