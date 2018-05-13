defmodule Wetter.MuensterUniversityData do
  require Logger
  @url "https://www.uni-muenster.de/Klima/wetter/wetter.php"

  def download_and_parse_weather_data do
    case HTTPoison.get(@url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        elements =
          body
          |> Floki.find(".data")
          |> Enum.map(fn url -> url |> elem(2) end)

        measured_at = Enum.at(elements, 0) |> hd |> String.trim()
        temperature = Enum.at(elements, 1) |> hd |> Float.parse() |> elem(0)
        description = Enum.at(elements, 11) |> hd |> String.trim()
        wind_speed = Enum.at(elements, 5) |> hd |> String.trim()

        {:ok,
         %{
           temperature: temperature,
           description: description,
           windSpeed: wind_speed,
           measuredAt: measured_at
         }}

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        Logger.error("404. MuensterUniversityData not found")
        {:error, "MuensterUniversityData not found"}

      {:error, %HTTPoison.Error{reason: reason}} ->
        Logger.error("MuensterUniversityData not found" <> Atom.to_string(reason))
        {:error, Atom.to_string(reason)}
    end
  end
end
