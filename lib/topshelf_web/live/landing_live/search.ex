defmodule TopshelfWeb.LandingLive.Search do
  defstruct search: ""

  def changeset(params \\ %{}) do
    data = %__MODULE__{}
    types = %{search: :string}

    {data, types}
    |> Ecto.Changeset.cast(params, Map.keys(types))
    |> Ecto.Changeset.validate_required([:search])
  end
end
