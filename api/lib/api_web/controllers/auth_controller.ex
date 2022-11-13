defmodule ApiWeb.AuthController do
  use ApiWeb, :controller
  import Plug.Conn
  import Ecto.Query, warn: false
  alias Api.Account
  alias ApiWeb.Utils
  alias ApiWeb.JWTToken
  alias Api.Authtokens.AuthToken
  alias Api.Repo

  def login(conn, %{"user" => %{"email" => email, "password" => password}}) do
    case Account.login(email, password) do
      {:ok, user} ->
        signer =
          Joken.Signer.create(
            "HS256",
            "yk2+GUuenj9gsBIv9Do3RIF5leb94vt30mLHlqoo8GoaGrayY+g88AdMVK4QdX+1"
          )

        extra_claims = %{user_id: user.id}
        {:ok, token, _claims} = JWTToken.generate_and_sign(extra_claims, signer)

        conn
        |> render("login.json", %{role: user.role, message: "Login Successful", token: token})

      _ ->
        conn |> render("error.json", %{error: Utils.invalid_credentials()})
    end
  end

  def get(conn, _params) do
    conn |> render("data.json", %{data: conn.assigns.current_user})
  end

  def logout(conn, _params) do
    case Ecto.build_assoc(conn.assigns.current_user, :auth_tokens, %{token: get_token(conn)})
         |> Repo.insert!() do
      %AuthToken{} -> conn |> render("ack.json", %{success: true, message: "Logged Out"})
      _ -> conn |> render("error.json", %{error: Utils.internal_server_error()})
    end
  end

  defp get_token(conn) do
    bearer =
      get_req_header(conn, "authorization")
      |> List.first()

    if bearer == nil do
      ""
    else
      bearer |> String.split(" ") |> List.last()
    end
  end
end
