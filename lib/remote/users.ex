defmodule Remote.Users do
  @moduledoc """
  The Users context.
  """

  import Ecto.Query, warn: false
  alias Remote.Repo

  alias Remote.Users.User

  def get_users_with_min_number(min_number) do
    User
    |> where([u], u.points > ^min_number)
    |> limit(2)
    |> Repo.all()
  end

  def update_points() do
    Repo.query("update users set points = floor(random()*100)")
  end

  def seed_users() do
    now = NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)

    1..1_000_000
    |> Stream.map(fn _ ->
      [points: 0, inserted_at: now, updated_at: now]
    end)
    |> Stream.chunk_every(21845)
    |> Stream.each(fn user ->
      Repo.insert_all(User, user)
    end)
    |> Stream.run()
  end

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end
end
