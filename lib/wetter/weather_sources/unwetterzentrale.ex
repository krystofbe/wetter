defmodule Wetter.Unwetterzentrale do
  require Logger
  @url "http://www.unwetterzentrale.de/uwz/getwarning_de.php?id=UWZDE48145"

  def download_and_parse_severe_weather_data do
    case HTTPoison.get(@url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        body
        |> Floki.find("#content")
        |> Floki.filter_out("script")
        |> Floki.filter_out("noscript")
        |> Floki.filter_out("ul")
        |> Floki.filter_out("p")
        |> Floki.filter_out("hr")
        |> Floki.raw_html()
        |> String.replace("../images", "/unwetterzentrale")
        |> String.replace("<img ", "<img alt=\"unwetterzentrale\" ")
        |> String.replace(
          "padding: 0px;",
          "padding: 0px; overflow: hidden;"
        )
        |> String.replace("h1", "h3")

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        Logger.error("404. Wetteronline rain radar tile not found")
        "Error 404. Please try again later."

      {:error, %HTTPoison.Error{reason: reason}} ->
        Logger.error("Wetteronline rain radar tile not found" <> Atom.to_string(reason))
        "Error. Please try again later."
    end
  end
end
