defmodule WetterWeb.ImageController do
  use WetterWeb, :controller
  alias Wetter.Images.Wetteronline
  alias Wetter.Images.Meteomedia
  alias Wetter.Images.Unwetterzentrale

  def wetteronline(conn, params) do
    case Wetteronline.rain_radar_tile(params) do
      {:ok, rain_radar_tile} ->
        conn
        |> put_resp_content_type("image/jpeg")
        |> send_resp(200, rain_radar_tile)

      {:error, error} ->
        conn
        |> send_resp(500, error)
    end
  end

  def meteomedia(conn, _params) do
    case Meteomedia.vorhersagegrafik() do
      {:ok, vorhersagegrafik} ->
        conn
        |> put_resp_content_type("image/png")
        |> send_resp(200, vorhersagegrafik)

      {:error, error} ->
        conn
        |> send_resp(500, error)
    end
  end

  def trendchart(conn, _params) do
    case Wetteronline.trendchart() do
      {:ok, trendchart} ->
        conn
        |> put_resp_content_type("image/png")
        |> send_resp(200, trendchart)

      {:error, error} ->
        conn
        |> send_resp(500, error)
    end
  end

  def unwetterzentrale(conn, %{"icon" => icon}) do
    conn
    |> put_resp_content_type("image/gif")
    |> send_resp(200, Unwetterzentrale.icon(icon))
  end
end
