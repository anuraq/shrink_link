defmodule ShrinkLink.Links do
  use Ecto.Schema

  schema "links" do
    field :blob, :string
    field :url, :string
  end

  def changeset(links, params \\ %{}) do
    links
    |> Ecto.Changeset.cast(params, [:blob, :url])
    |> Ecto.Changeset.validate_required([:blob, :url])
  end
end
