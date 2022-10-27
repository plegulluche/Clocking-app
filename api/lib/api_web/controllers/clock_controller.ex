defmodule ApiWeb.ClockController do
  use ApiWeb, :controller

  alias Api.Directory
  alias Api.Directory.Clock

  action_fallback(ApiWeb.FallbackController)

  def index(conn, _params) do
    clocks = Directory.list_clocks()
    render(conn, "index.json", clocks: clocks)
  end

  def create(conn, %{"userID" => user}) do
    clock = Clocking.get_clock!(user)

    if is_nil(clock) do
      with {:ok, %Clock{} = clock} <-
             Clocking.create_clock(%{
               "user_id" => user,
               "time" => DateTime.utc_now(),
               "status" => true
             }) do
        conn
        |> put_status(:created)
        |> render("show.json", clock: clock)
      end
    else
      if clock.status do
        Workingtimes.create_workingtime(%{
          "start" => clock.time,
          "end" => DateTime.utc_now(),
          "user_id" => user
        })

        clock_params = %{"time" => DateTime.utc_now(), "status" => false}

        with {:ok, %Clock{} = clock} <- Clocking.update_clock(clock, clock_params) do
          render(conn, "show.json", clock: clock)
        end
      else
        clock_params = %{"time" => DateTime.utc_now(), "status" => true}

        with {:ok, %Clock{} = clock} <- Clocking.update_clock(clock, clock_params) do
          render(conn, "show.json", clock: clock)
        end
      end
    end
  end

  def show(conn, %{"id" => id}) do
    clock = Directory.get_clock!(id)
    render(conn, "show.json", clock: clock)
  end

  def update(conn, %{"id" => id, "clock" => clock_params}) do
    clock = Directory.get_clock!(id)

    with {:ok, %Clock{} = clock} <- Directory.update_clock(clock, clock_params) do
      render(conn, "show.json", clock: clock)
    end
  end

  def delete(conn, %{"id" => id}) do
    clock = Directory.get_clock!(id)

    with {:ok, %Clock{}} <- Directory.delete_clock(clock) do
      send_resp(conn, :no_content, "")
    end
  end
end
