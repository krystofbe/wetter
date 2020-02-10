defmodule WetterWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :wetter

  socket("/socket", WetterWeb.UserSocket,
    websocket: true,
    longpoll: false
  )

  # Serve at "/" the static files from "priv/static" directory.
  #
  # You should set gzip to true if you are running phx.digest
  # when deploying your static files in production.
  plug(Plug.Static,
    at: "/",
    from: :wetter,
    gzip: false,
    only: ~w(css fonts images js favicon.ico robots.txt)
  )

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    socket("/phoenix/live_reload/socket", Phoenix.LiveReloader.Socket)
    plug(Phoenix.LiveReloader)
    plug(Phoenix.CodeReloader)
  end

  plug(Plug.RequestId)
  plug(Plug.Logger)

  plug(Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()
  )

  plug(Plug.MethodOverride)
  plug(Plug.Head)

  # The session will be stored in the cookie and signed,
  # this means its contents can be read but not tampered with.
  # Set :encryption_salt if you would also like to encrypt it.
  plug(Plug.Session,
    store: :cookie,
    key: "_wetter_key",
    signing_salt: "3tat8+Kr"
  )

  plug(WetterWeb.Router)

  @doc """
  Callback invoked for dynamically configuring the endpoint.
  It receives the endpoint configuration and checks if
  configuration should be loaded from the system environment.
  """
  def init(_key, config) do
    if config[:load_from_system_env] do
      host = System.get_env("DEFAULT_URL_HOST")

      url = [
        host: host,
        port: from_env("HTTP_PORT"),
        scheme: from_env("HTTP_SCHEME")
      ]

      config =
        config
        |> Keyword.put(:http, port: from_env("PORT"))
        |> Keyword.put(:secret_key_base, from_env("SECRET_KEY_BASE"))
        |> Keyword.put(:url, url)

      {:ok, config}
    else
      {:ok, config}
    end
  end

  defp from_env(env) do
    System.get_env(env) || raise "expected the #{env} environment variable to be set"
  end
end
