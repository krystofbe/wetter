defmodule Wetter.Images.Unwetterzentrale do
  require Logger
  @icon_url "http://www.unwetterzentrale.de/images/icons/"

  def icon(icon) do
    case HTTPoison.get(@icon_url <> icon) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        body

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        Logger.error("404. icon not found")
        {:error, "404. icon not found"}

      {:error, %HTTPoison.Error{reason: reason}} ->
        Logger.error("Wetteronline icon not found" <> Atom.to_string(reason))
        {:error, "404. icon not found"}
    end
  end
end
