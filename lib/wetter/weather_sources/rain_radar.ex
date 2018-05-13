defmodule Wetter.RainRadar do
  require Logger
  @url "https://mtfm.wetteronline.de/metadata?&bev=1&wrextent=europe"

  def download_rain_radar_data do
    case HTTPoison.get(@url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok,
         body
         |> Poison.decode!()
         |> get_in(["periods", "current_15"])}

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        Logger.error("404. Wetteronline rain radar tile not found")
        {:error, ""}

      {:error, %HTTPoison.Error{reason: reason}} ->
        Logger.error("Wetteronline rain radar tile not found" <> Atom.to_string(reason))
        {:ok, ""}
    end
  end
end
