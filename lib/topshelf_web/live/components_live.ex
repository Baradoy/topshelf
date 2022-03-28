defmodule TopshelfWeb.LiveComponents do
  use TopshelfWeb, :live_component

  use PetalComponents

  defp assign_class_and_extra_attribures(assigns, default_class) do
    assigns
    |> assign_new(:class, fn -> "" end)
    |> update(:class, fn class -> default_class <> " " <> class end)
    |> assign_new(:extra_assigns, fn ->
      assigns_to_attributes(assigns, ~w(
          class
        )a)
    end)
  end

  def dl(assigns) do
    class = ""
    assigns = assign_class_and_extra_attribures(assigns, class)

    ~H"""
    <dl class={ @class } {@extra_assigns}>
      <%= render_slot(@inner_block) %>
    </dl>
    """
  end

  def dt(assigns) do
    class = "mt-2 font-medium block text-gray-900 dark:text-gray-200"
    assigns = assign_class_and_extra_attribures(assigns, class)

    ~H"""
    <dt class={ @class } {@extra_assigns}>
      <%= render_slot(@inner_block) %>
    </dt>
    """
  end

  def dd(assigns) do
    class = "text-sm block text-gray-900 dark:text-gray-200"
    assigns = assign_class_and_extra_attribures(assigns, class)

    ~H"""
    <dd class={ @class } {@extra_assigns}>
      <%= render_slot(@inner_block) %>
    </dd>
    """
  end

  def tabbed_container(assigns) do
    assigns =
      assigns
      |> assign_new(:landing, fn -> false end)
      |> assign_new(:shopping, fn -> false end)
      |> assign_new(:bottles, fn -> false end)
      |> assign_new(:shelves, fn -> false end)
      |> assign_new(:recipes, fn -> false end)

    ~H"""
    <.container max_width="xl">
      <.tabs underline>
        <.tab underline is_active={@landing} link_type="live_redirect" to="/">
          <Heroicons.Outline.sparkles class="w-5 h-5 mr-2" />
            Home
        </.tab>
        <.tab underline is_active={@shopping} link_type="live_redirect" to={ Routes.bottle_index_path(TopshelfWeb.Endpoint, :shopping) }>
          <Heroicons.Outline.clipboard_list class="w-5 h-5 mr-2" />
            Shopping
        </.tab>
        <.tab underline is_active={@bottles} link_type="live_redirect" to={ Routes.bottle_index_path(TopshelfWeb.Endpoint, :index) }>
          <Heroicons.Outline.beaker class="w-5 h-5 mr-2" />
            Bottles
        </.tab>
        <.tab underline is_active={@shelves} link_type="live_redirect" to={ Routes.shelf_index_path(TopshelfWeb.Endpoint, :index) }>
          <Heroicons.Outline.library class="w-5 h-5 mr-2" />
            Shelves
        </.tab>
        <.tab underline is_active={@recipes} link_type="live_redirect" to={ Routes.recipe_index_path(TopshelfWeb.Endpoint, :index) }>
          <Heroicons.Outline.server class="w-5 h-5 mr-2" />
          Recipes
        </.tab>
      </.tabs>
      <%= render_slot(@inner_block) %>
    </.container>
    """
  end
end
