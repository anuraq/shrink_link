import Config

config :shrink_link, ShrinkLink.Repo,
  database: "shrink_link_repo",
  username: "postgres",
  password: "ROOTUSER",
  hostname: "localhost"

config :shrink_link, ecto_repos: [ShrinkLink.Repo]
