defmodule TopshelfWeb.PageController do
  use TopshelfWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
