defmodule Wetter.UnwetterzentraleTest do
  use WetterWeb.ConnCase

  alias Wetter.Unwetterzentrale

  test "get unwetterzentrale servere weather data" do
    weather = Unwetterzentrale.download_and_parse_severe_weather_data()
    assert weather =~ "Unwetterwarnungen für Münster"
  end
end
