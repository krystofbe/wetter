defmodule Wetter.MuensterUniversityDataTest do
  use WetterWeb.ConnCase

  alias Wetter.MuensterUniversityData

  test "get muenster university weather data" do
    weather = MuensterUniversityData.download_and_parse_weather_data()
    assert weather.temperature > -50
  end
end