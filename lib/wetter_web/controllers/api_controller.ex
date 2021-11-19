defmodule WetterWeb.ApiController do
  use WetterWeb, :controller
  alias Wetter.MuensterUniversityData

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
end
