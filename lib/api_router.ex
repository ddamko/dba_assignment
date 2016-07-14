defmodule APIRouter do
  use Plug.Router
  alias RethinkDB.Query

  plug Corsica, [origins: "http://localhost:8888",
                 allow_headers: ~w(ACCEPT Content-Type Access-Control-Allow-Origin Access-Control-Allow-Headers Access-Control-Allow-Methods)]

  plug :match
  plug :dispatch

  get "/api/all" do
    query = Query.table("bulls")
            |> SiresDB.run

    json = Poison.encode!(query)
    send_resp(conn, 200, json)
  end

  get "/api/active" do
    query = Query.table("bulls")
            |> Query.filter(%{ACTIVE: "1"})
            |> SiresDB.run

    json = Poison.encode!(query)
    send_resp(conn, 200, json)
  end

  get "/api/country/:country/" do
    query = Query.table("bulls")
            |> Query.filter(%{COUNTRY: "#{country}"})
            |> SiresDB.run

    json = Poison.encode!(query)
    send_resp(conn, 200, json)
  end

  get "/api/active/:country/" do
    query = Query.table("bulls")
            |> Query.filter(%{ACTIVE: "1", COUNTRY: "#{country}"})
            |> SiresDB.run

    json = Poison.encode!(query)
    send_resp(conn, 200, json)
  end

  get "/api/breed/:breed/" do
    query = Query.table("bulls")
            |> Query.filter(%{BREED: "#{breed}"})
            |> SiresDB.run

    json = Poison.encode!(query)
    send_resp(conn, 200, json)
  end

  get "/api/uid/:uid/" do
    query = Query.table("bulls")
            |> Query.filter(%{UID: "#{uid}"})
            |> SiresDB.run

    json = Poison.encode!(query)
    send_resp(conn, 200, json)
  end

  get "/api/get_uids" do
    query = Query.table("bulls")
            |> Query.pluck("UID")
            |> SiresDB.run

    json = Poison.encode!(query)
    send_resp(conn, 200, json)
  end

  match _ do
    send_resp(conn, 404, "Oops, nothing is here.")
  end
end
