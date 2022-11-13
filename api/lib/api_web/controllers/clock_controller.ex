defmodule ApiWeb.ClockController do
  use ApiWeb, :controller

  alias Api.Timer
  alias Api.Timer.Clock

  action_fallback ApiWeb.FallbackController


  def index(conn, %{"user_id" => _} = params) do
    clocks = Timer.list_clocks(params)
    render(conn, "index.json", clocks: clocks)
  end

  def index(conn, _params) do
    clocks = Timer.list_clocks()
    render(conn, "index.json", clocks: clocks)
  end

  def get_two_last_clocks(conn, %{"user_id" => _} = params) do
    clocks = Timer.get_last_two_clocks(params)
    render(conn, "index.json", clocks: clocks)
  end

  def get_two_last_clocks(conn, _params) do
    user_id = conn.assigns.current_user.id
    user = %{"user_id" => user_id}
    clocks = Timer.get_last_two_clocks(user)
    render(conn, "index.json", clocks: clocks)
  end

  def create(conn, %{"clock" => clock_params}) do
    if clock_params["user_id"] == "" do
      user = conn.assigns.current_user.id
      clock_params_with_user_id = Map.replace(clock_params, "user_id", user)
      with {:ok, %Clock{} = clock} <- Timer.create_clock(clock_params_with_user_id) do
        conn
        |> put_status(:created)
        |> put_resp_header("location", Routes.clock_path(conn, :show, clock))
        |> render("show.json", clock: clock)
      end
    else
      with {:ok, %Clock{} = clock} <- Timer.create_clock(clock_params) do
        conn
        |> put_status(:created)
        |> put_resp_header("location", Routes.clock_path(conn, :show, clock))
        |> render("show.json", clock: clock)
      end
    end
  end



  def show(conn, %{"id" => id}) do
    clock = Timer.get_clock!(id)
    render(conn, "show.json", clock: clock)
  end

  # def show(conn, %{"user_id" => id}) do
  #   clocks = Timer.get_clock_by_user_id(id)
  #   render(conn, "show.json", clocks: clocks)
  # end

  def update(conn, %{"id" => id, "clock" => clock_params}) do
    clock = Timer.get_clock!(id)

    with {:ok, %Clock{} = clock} <- Timer.update_clock(clock, clock_params) do
      render(conn, "show.json", clock: clock)
    end
  end

  def delete(conn, %{"id" => id}) do
    clock = Timer.get_clock!(id)

    with {:ok, %Clock{}} <- Timer.delete_clock(clock) do
      send_resp(conn, :no_content, "")
    end
  end
end
