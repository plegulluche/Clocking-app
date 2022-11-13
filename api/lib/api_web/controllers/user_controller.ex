defmodule ApiWeb.UserController do
  use ApiWeb, :controller

  alias Api.Account
  alias Api.Account.User

  action_fallback ApiWeb.FallbackController

  @spec index(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def index(conn, %{"email" => _, "username" => _} = params) do
    IO.puts "++Inside index USer++"
    IO.inspect(params)
    user = Account.get_user(params)
    render(conn, "show.json", user: user)
  end

  def index(conn, _params) do
    if conn.assigns.current_user.role == "employee" do
      render(conn, "error.json", %{success: false, message: "You don't have the permission to do this"})
    end

    users = Account.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Account.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Account.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Account.get_user!(id)

    with {:ok, %User{} = user} <- Account.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def update_user_without_id(conn, %{"user" => user_params}) do
    current_user = conn.assigns.current_user.id
    user = Account.get_user!(current_user)
    with {:ok, %User{} = user} <- Account.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end


  #Delete a User passing ID as a query string
  def delete(conn, %{"id" => id}) do
    user = Account.get_user!(id)

    with {:ok, %User{}} <- Account.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
  #Delete method for the current logged in user
  def delete_user_without_id(conn, _params) do
    user_id = conn.assigns.current_user.id
    user = Account.get_user!(user_id)
    with {:ok, %User{}} <- Account.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
