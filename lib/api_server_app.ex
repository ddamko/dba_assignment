defmodule APIServerApp do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      # Define workers and child supervisors to be supervised
      # Running a HTTP API routing server with Cowboy on port 3000
      Plug.Adapters.Cowboy.child_spec(:http, APIRouter, [], [port: 3000]),
      # RethinkDB Connection Worker
      worker(SiresDB, [[port: 28015, host: "localhost", db: "sires"]])
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: APIServerApp.Supervisor]
    Supervisor.start_link(children, opts)
  end

end
