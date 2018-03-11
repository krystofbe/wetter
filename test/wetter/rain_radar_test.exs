defmodule Wetter.RainRadarTest do
  use WetterWeb.ConnCase

  alias Wetter.RainRadar

  test "get rain radar data" do
    rain_radar_data = RainRadar.download_rain_radar_data()
  end
end