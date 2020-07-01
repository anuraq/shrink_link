defmodule ShrinkLink.Repo.Migrations.CreateLinks do
  use Ecto.Migration

  def change do
    create table(:links) do
      add :blob, :string
      add :url, :string
    end
  end
end
