defmodule WetterWeb.ApiController do
  use WetterWeb, :controller
  alias Wetter.MuensterUniversityData
  alias Wetter.RainRadar

  def university_data(conn, _params) do
    case MuensterUniversityData.download_and_parse_weather_data() do
      {:ok, university_data} ->
        conn
        |> json(university_data)

      {:error, error} ->
        conn
        |> send_resp(500, error)
    end
  end

  def rainradar(conn, _params) do
    case RainRadar.download_rain_radar_data() do
      {:ok, rain_radar_data} ->
        json = Poison.encode!(rain_radar_data)

        conn
        |> json(json)

      {:error, error} ->
        conn
        |> send_resp(500, error)
    end
  end
end
