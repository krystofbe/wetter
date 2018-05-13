defmodule Wetter.RainRadarTest do
  use WetterWeb.ConnCase

  alias Wetter.RainRadar

  test "get rain radar data" do
    RainRadar.download_rain_radar_data()
  end
end
