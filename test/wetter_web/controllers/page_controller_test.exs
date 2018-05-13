defmodule WetterWeb.PageControllerTest do
  use WetterWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Münster Wetter"
  end
end
