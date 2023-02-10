# User Points

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup` which will also seed the database with 1 million users
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

After startup a timer is started and every minute several things happen:

  * A minimum number of points is generated at random from 0-100 and held in memory
  * All users in the database are updated with a random number of points between 0-100

# How to use

Send a GET request to / to get a json response of 2 users who's points are above the current minimum points, along with the timestamp of the previous request.
