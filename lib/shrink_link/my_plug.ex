defmodule ShrinkLink.MyPlug do
  use Plug.Router
  alias ShrinkLink.Repo
  alias ShrinkLink.Links
  import Ecto.Query, only: [from: 2]

  plug :match
  plug Plug.Parsers, parsers: [:json],
                   pass:  ["application/json"],
                   json_decoder: Jason
  plug :dispatch


  post "/url" do
    IO.inspect conn.body_params
    %{"url" => url} = conn.body_params
    blob = Map.get(conn.body_params, "blob")
    blob = unless blob, do: Nanoid.generate(5), else: blob
    blob = String.downcase(blob)
    {:ok, map} = JSON.Encoder.encode(%{blob: blob, url: url})
    #changeset = Links.changeset(%Links{}, %{blob: blob, url: url})
    c = Repo.exists?(from u in ShrinkLink.Links, where: u.blob == ^blob)
    #Repo.insert(changeset)
    IO.puts("Blob is #{blob} and Url is #{url} and count is #{c}")
    update_resp_header(conn,"content-type","application/json; charset=utf-8",&(&1 <> "; charset=utf-8")) |> send_resp( 200, map)
  end

  match _ do
    send_resp(conn, 404, "oops")
  end

  defp generate_nanoid do

  end


end
