defmodule TopshelfWeb.LiveComponents do
  use Phoenix.Component

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
end
