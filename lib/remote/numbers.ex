defmodule Remote.Numbers do
  use GenServer
  alias Remote.Users
  require Logger

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  @impl true
  def init(_opts) do
    restart()
    {:ok, %{min_number: 0, timestamp: nil}}
  end

  @impl true
  def handle_info(:update, state) do
    restart()
    state = %{state | min_number: :rand.uniform(100)}
    Task.async(fn -> Users.update_points() end)
    {:noreply, state}
  end

  @impl true
  def handle_info(_, state), do: {:noreply, state}

  @impl true
  def handle_call(:get, _from, state) do
    reply = %{
      timestamp: state.timestamp,
      users: Users.get_users_with_min_number(state.min_number)
    }

    state = %{state | timestamp: DateTime.utc_now()}
    {:reply, reply, state}
  end

  def get_users() do
    GenServer.call(__MODULE__, :get)
  end

  defp restart() do
    Process.send_after(self(), :update, 60 * 1000)
  end
end
