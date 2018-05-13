defmodule Wetter.Images.Wetteronline do
  require Logger

  @tile_url "https://mtfm.wetteronline.de/tiles"
  @trendchart_url "https://www.wetteronline.de/?pid=p_city_local&gid=10315&trendchart=true&diagram=true&c=f"

  def rain_radar_tile(params) do
    case HTTPoison.get(@tile_url, [], params: params) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, body}

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        Logger.error("404. rain radar tile not found")
        {:error, "404. rain radar tile not found"}

      {:error, %HTTPoison.Error{reason: reason}} ->
        Logger.error("Wetteronline rain radar tile not found" <> Atom.to_string(reason))
        {:error, "404. rain radar tile not found"}
    end
  end

  def trendchart() do
    case HTTPoison.get(@trendchart_url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, body}

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        Logger.error("404. trendchart not found")
        {:error, "trendchart not found"}

      {:error, %HTTPoison.Error{reason: reason}} ->
        Logger.error("Wetteronline not found" <> Atom.to_string(reason))

        {:error, Atom.to_string(reason)}
    end
  end
end
