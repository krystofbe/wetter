defmodule Wetter.Images.Wetteronline do
  @tile_url "https://mtfm.wetteronline.de/tiles"
  @trendchart_url "https://www.wetteronline.de/?pid=p_city_local&gid=10315&trendchart=true&diagram=true&c=f"

  def rain_radar_tile(params) do
    case HTTPoison.get(@tile_url, [], params: params) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        body

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        IO.puts("Not found :(")

      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect(reason)
    end
  end

  def trendchart() do
    case HTTPoison.get(@trendchart_url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        body

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        IO.puts("Not found :(")

      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect(reason)
    end
  end
end
