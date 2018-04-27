defmodule Wetter.MuensterUniversityData do
  @url "https://www.uni-muenster.de/Klima/wetter/wetter.php"

  def download_and_parse_weather_data do
    case HTTPoison.get(@url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        elements =
          body
          |> Floki.find(".data")
          |> Enum.map(fn url -> url |> elem(2) end)

        temperature = Enum.at(elements, 1) |> hd |> Float.parse() |> elem(0)
        description = Enum.at(elements, 11) |> hd
        wind_speed = Enum.at(elements, 5) |> hd

        %{temperature: temperature, description: description, wind_speed: wind_speed}

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        IO.puts("Not found :(")

      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect(reason)
    end
  end
end
