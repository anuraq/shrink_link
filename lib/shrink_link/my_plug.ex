defmodule ShrinkLink.MyPlug do
  use Plug.Router

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
    IO.puts("Blob is #{blob} and Url is #{url}")
    send_resp(conn, 200, "Success!!")
  end

  match _ do
    send_resp(conn, 404, "oops")
  end


end
