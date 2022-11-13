defmodule ApiWeb.WorkingtimeController do
  use ApiWeb, :controller

  alias Api.Timer
  alias Api.Timer.Workingtime

  action_fallback ApiWeb.FallbackController

  def index(conn, %{"id" => _,"start" => _, "end" => _} = params) do
    IO.puts "++INSIDE INDEX/3++"
    workingtimes = Timer.list_workingtimes(params)
    render(conn, "index.json", workingtimes: workingtimes)
  end

  def index(conn, %{"user_id" => _} = params) do
    workingtimes = Timer.list_workingtimes(params)
    render(conn, "index2.json", workingtimes: workingtimes)
  end

  def index(conn, _params) do
    if conn.assigns.current_user.role == "general_manager" do
      workingtimes = Timer.list_workingtimes()
      render(conn, "index2.json", workingtimes: workingtimes)
    else
    user_id = conn.assigns.current_user.id
    params = %{"user_id" => user_id}
    workingtimes = Timer.list_workingtimes(params)
    render(conn, "index2.json", workingtimes: workingtimes)
    end
  end


  def create(conn, %{"workingtime" => workingtime_params}) do
    if workingtime_params["user_id"] == "" do
      user = conn.assigns.current_user.id
      workingtime_params_with_user_id = Map.replace(workingtime_params, "user_id", user)
      with {:ok, %Workingtime{} = workingtime} <- Timer.create_workingtime(workingtime_params_with_user_id) do
        conn
        |> put_status(:created)
        |> put_resp_header("location", Routes.workingtime_path(conn, :show, workingtime))
        |> render("show.json", workingtime: workingtime)
      end
    else
      with {:ok, %Workingtime{} = workingtime} <- Timer.create_workingtime(workingtime_params) do
        conn
        |> put_status(:created)
        |> put_resp_header("location", Routes.workingtime_path(conn, :show, workingtime))
        |> render("show.json", workingtime: workingtime)
      end
    end
  end
  #Get a working time with the workingtime id
  def show(conn, %{"id" => id}) do
    workingtime = Timer.get_workingtime!(id)
    render(conn, "show.json", workingtime: workingtime)
  end

  def update(conn, %{"id" => id, "workingtime" => workingtime_params}) do
    workingtime = Timer.get_workingtime!(id)

    with {:ok, %Workingtime{} = workingtime} <- Timer.update_workingtime(workingtime, workingtime_params) do
      render(conn, "show.json", workingtime: workingtime)
    end
  end

  def delete(conn, %{"id" => id}) do
    workingtime = Timer.get_workingtime!(id)

    with {:ok, %Workingtime{}} <- Timer.delete_workingtime(workingtime) do
      send_resp(conn, :no_content, "")
    end
  end
end
