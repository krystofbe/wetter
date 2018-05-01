defmodule Wetter.Images.Meteomedia do
  @url "http://wetterstationen.meteomedia.de/messnetz/vorhersagegrafik/103130.png?ver=1520770212"
  def vorhersagegrafik() do
    case HTTPoison.get(@url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        body

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        IO.puts("Not found :(")

      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect(reason)
    end
  end
end
