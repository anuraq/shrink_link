defmodule ShrinkLink.MyPlug do
  use Plug.Router
  alias ShrinkLink.Repo
  alias ShrinkLink.Links
  import Ecto.Query, only: [from: 2]
  @template_dir "lib/shrink_link/templates"


  if Mix.env == :dev do
    use Plug.Debugger
  end

  plug Plug.Logger
  plug :match
  plug Plug.Parsers, parsers: [:urlencoded, :json],
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
    c = Repo.exists?(from u in Links, where: u.blob == ^blob)
    #Repo.insert(changeset)
    if c, do: send_response_NO(conn), else: send_response_OK(conn, map)
    #IO.puts("Blob is #{blob} and Url is #{url} and count is #{c}")
    send_resp(conn, 200, "OK");
  end

  get "/" do
    body =
    @template_dir
    |> Path.join("index.html")
    |> String.replace_suffix(".html", ".html.eex")
    |> EEx.eval_file(a: [])
    send_resp(conn, 200, body)
  end

  get "/blob/:blob" do
    IO.puts("blob is #{blob}")
    c = Repo.exists?(from u in ShrinkLink.Links, where: u.blob == ^blob)
    {:ok, address} = if(c, do: Repo.get_by(ShrinkLink.Links, blob: blob) |> Map.fetch(:url) , else: {:ok, "not_found"})

    conn |> Plug.Conn.resp(:found, "") |> Plug.Conn.put_resp_header("location", "https://" <> address)
  end

  match _ do
    send_resp(conn, 404, "oops")
  end

  defp send_response_OK(conn, map) do
    update_resp_header(conn,"content-type","application/json; charset=utf-8",&(&1 <> "; charset=utf-8")) |> send_resp( 200, map)
  end

  defp send_response_NO(conn) do
    send_resp(conn ,200, "id exists give another one")
  end

end
