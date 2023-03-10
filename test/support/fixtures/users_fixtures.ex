defmodule Remote.UsersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Remote.Users` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        points: :rand.uniform(100)
      })
      |> Remote.Users.create_user()

    user
  end
end
