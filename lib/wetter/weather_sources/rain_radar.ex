defmodule Wetter.RainRadar do
  @url "https://mtfm.wetteronline.de/metadata?&bev=1&wrextent=europe"

  def download_rain_radar_data do
    case HTTPoison.get(@url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        elements =
          body
          |> Poison.decode!()
          |> get_in(["periods", "current_15"])

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        IO.puts("Not found :(")

      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect(reason)
    end
  end
end