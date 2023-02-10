defmodule RemoteWeb.PageController do
  use RemoteWeb, :controller
  alias Remote.Numbers

  def home(conn, _params) do
    response = Numbers.get_users()
    render(conn, :index, response: response)
  end
end
