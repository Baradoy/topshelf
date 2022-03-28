defmodule TopshelfWeb.LandingLive.Search do
  defstruct search: "", percent: nil

  def changeset(params \\ %{}) do
    data = %__MODULE__{}
    types = %{search: :string, percent: :integer}

    {data, types}
    |> Ecto.Changeset.cast(params, Map.keys(types))
  end
end
