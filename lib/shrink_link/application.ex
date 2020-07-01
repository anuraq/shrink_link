defmodule ShrinkLink.Application do
  use Application
  require Logger

  def start(_type, _args) do
    children = [
      {Plug.Cowboy, scheme: :http, plug: ShrinkLink.MyPlug, options: [port: 8080]},
      {ShrinkLink.Repo, []}
    ]
    opts = [strategy: :one_for_one, name: ShrinkLink.Supervisor]

    Logger.info("Starting application...")

    Supervisor.start_link(children, opts)
  end
end
