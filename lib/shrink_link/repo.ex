defmodule ShrinkLink.Repo do
  use Ecto.Repo,
    otp_app: :shrink_link,
    adapter: Ecto.Adapters.Postgres
end
