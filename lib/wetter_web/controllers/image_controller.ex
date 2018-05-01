defmodule WetterWeb.ImageController do
  use WetterWeb, :controller
  alias Wetter.Images.Wetteronline
  alias Wetter.Images.Meteomedia
  alias Wetter.Images.Unwetterzentrale

  def wetteronline(conn, params) do
    IO.inspect(params)

    conn
    |> put_resp_content_type("image/jpeg")
    |> send_resp(200, Wetteronline.rain_radar_tile(params))
  end

  def meteomedia(conn, params) do
    IO.inspect(params)

    conn
    |> put_resp_content_type("image/png")
    |> send_resp(200, Meteomedia.vorhersagegrafik())
  end

  def trendchart(conn, params) do
    IO.inspect(params)

    conn
    |> put_resp_content_type("image/png")
    |> send_resp(200, Wetteronline.trendchart())
  end

  def unwetterzentrale(conn, %{"icon" => icon}) do
    conn
    |> put_resp_content_type("image/gif")
    |> send_resp(200, Unwetterzentrale.icon(icon))
  end
end
