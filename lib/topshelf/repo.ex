defmodule Topshelf.Repo do
  use Ecto.Repo,
    otp_app: :topshelf,
    adapter: Ecto.Adapters.SQLite3
end
