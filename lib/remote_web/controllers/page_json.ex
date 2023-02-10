defmodule RemoteWeb.PageJSON do
  alias Remote.Users.User

  def index(%{response: response}) do
    %{users: for(user <- response.users, do: data(user)), timestamp: response.timestamp}
  end

  defp data(%User{} = user) do
    %{
      id: user.id,
      points: user.points
    }
  end
end
