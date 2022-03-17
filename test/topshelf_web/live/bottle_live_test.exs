defmodule TopshelfWeb.BottleLiveTest do
  use TopshelfWeb.ConnCase

  import Phoenix.LiveViewTest
  import Topshelf.Factory

  @update_attrs %{
    abv: 456.7,
    brand: "some updated brand",
    description: "some updated description",
    name: "some updated name",
    type: "some updated type",
    url: "some updated url",
    volume: "some updated volume"
  }
  @invalid_attrs %{
    abv: nil,
    brand: nil,
    description: nil,
    name: nil,
    type: nil,
    url: nil,
    volume: nil
  }

  defp create_bottle(_) do
    bottle = insert(:bottle)
    %{bottle: bottle}
  end

  describe "Index" do
    setup [:create_bottle]

    test "lists all bottles", %{conn: conn, bottle: bottle} do
      {:ok, _index_live, html} = live(conn, Routes.bottle_index_path(conn, :index))

      assert html =~ "Listing Bottles"
      assert html =~ bottle.brand
    end

    test "saves new bottle", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.bottle_index_path(conn, :index))

      assert index_live |> element("a", "New Bottle") |> render_click() =~
               "New Bottle"

      assert_patch(index_live, Routes.bottle_index_path(conn, :new))

      assert index_live
             |> form("#bottle-form", bottle: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#bottle-form", bottle: params_for(:bottle))
        |> render_submit()
        |> follow_redirect(conn, Routes.bottle_index_path(conn, :index))

      assert html =~ "Bottle created successfully"
      assert html =~ "some brand"
    end

    test "updates bottle in listing", %{conn: conn, bottle: bottle} do
      {:ok, index_live, _html} = live(conn, Routes.bottle_index_path(conn, :index))

      assert index_live |> element("#bottle-#{bottle.id} a", "Edit") |> render_click() =~
               "Edit Bottle"

      assert_patch(index_live, Routes.bottle_index_path(conn, :edit, bottle))

      assert index_live
             |> form("#bottle-form", bottle: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#bottle-form", bottle: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.bottle_index_path(conn, :index))

      assert html =~ "Bottle updated successfully"
      assert html =~ "some updated brand"
    end

    test "deletes bottle in listing", %{conn: conn, bottle: bottle} do
      {:ok, index_live, _html} = live(conn, Routes.bottle_index_path(conn, :index))

      assert index_live |> element("#bottle-#{bottle.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#bottle-#{bottle.id}")
    end
  end

  describe "Show" do
    setup [:create_bottle]

    test "displays bottle", %{conn: conn, bottle: bottle} do
      {:ok, _show_live, html} = live(conn, Routes.bottle_show_path(conn, :show, bottle))

      assert html =~ "Show Bottle"
      assert html =~ bottle.brand
    end

    test "updates bottle within modal", %{conn: conn, bottle: bottle} do
      {:ok, show_live, _html} = live(conn, Routes.bottle_show_path(conn, :show, bottle))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Bottle"

      assert_patch(show_live, Routes.bottle_show_path(conn, :edit, bottle))

      assert show_live
             |> form("#bottle-form", bottle: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#bottle-form", bottle: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.bottle_show_path(conn, :show, bottle))

      assert html =~ "Bottle updated successfully"
      assert html =~ "some updated brand"
    end
  end
end
