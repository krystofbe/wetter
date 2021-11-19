defmodule Wetter.Images.Meteomedia do
  require Logger
  @url "https://wetterstationen.meteomedia.de/messnetz/vorhersagegrafik/103130.png?ver=1623143405"
  def vorhersagegrafik() do
    case HTTPoison.get(@url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, body}

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        Logger.error("404. vorhersagegrafik not found")
        {:error, "404. vorhersagegrafik not found"}

      {:error, %HTTPoison.Error{reason: reason}} ->
        Logger.error("Wetteronline vorhersagegrafik not found" <> Atom.to_string(reason))
        {:error, "404. vorhersagegrafik not found"}
    end
  end
end
