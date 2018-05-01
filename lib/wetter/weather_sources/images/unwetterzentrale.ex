defmodule Wetter.Images.Unwetterzentrale do
  @icon_url "http://www.unwetterzentrale.de/images/icons/"

  def icon(icon) do
    case HTTPoison.get(@icon_url <> icon) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        body

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        IO.puts("Not found :(")

      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect(reason)
    end
  end
end
