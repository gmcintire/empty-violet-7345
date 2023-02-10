defmodule RemoteWeb.PageControllerTest do
  use RemoteWeb.ConnCase

  test "GET / with no users", %{conn: conn} do
    conn = get(conn, ~p"/")

    # first request should return no timestamp
    assert json_response(conn, 200) == %{"timestamp" => nil, "users" => []}

    # make another request, and expect a timestamp
    conn = get(conn, ~p"/")
    response = json_response(conn, 200)
    assert not is_nil(response["timestamp"])
  end
end
