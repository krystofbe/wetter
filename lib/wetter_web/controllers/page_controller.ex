defmodule WetterWeb.PageController do
  use WetterWeb, :controller
  alias Wetter.MuensterUniversityData
  alias Wetter.Unwetterzentrale
  alias Wetter.RainRadar

  def index(conn, _params) do
    university_data = MuensterUniversityData.download_and_parse_weather_data()
    severe_weather_data = Unwetterzentrale.download_and_parse_severe_weather_data()
    sunrise = Solar.event(:rise, {51.9606649, 7.6261347}) |> elem(1)
    sunset = Solar.event(:set, {51.9606649, 7.6261347}) |> elem(1)
    rain_radar_data = RainRadar.download_rain_radar_data()

    render(
      conn,
      "index.html",
      university_data: university_data,
      sunrise: sunrise,
      sunset: sunset,
      severe_weather_data: severe_weather_data,
      rain_radar_data: rain_radar_data
    )
  end
end