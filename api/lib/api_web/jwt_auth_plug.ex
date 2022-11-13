defmodule ApiWeb.JWTAuthPlug do
  import Plug.Conn
  alias Api.Account
  alias Api.AuthTokens
  # alias Api.Account.User

  def init(opts), do: opts

  def call(conn, _) do
    bearer = get_req_header(conn, "authorization") |> List.first()

    if bearer == nil do
      conn |> put_status(401) |> halt
    else
      token = bearer |> String.split(" ") |> List.last()

      signer =
        Joken.Signer.create(
          "HS256",
          "yk2+GUuenj9gsBIv9Do3RIF5leb94vt30mLHlqoo8GoaGrayY+g88AdMVK4QdX+1"
        )

      with {:ok, %{"user_id" => user_id}} <-
             ApiWeb.JWTToken.verify_and_validate(token, signer),
           {:ok, user} <- Account.test_id(user_id) do
        if AuthTokens.get_auth_token_by_token(token) != nil do
          conn |> put_status(401) |> halt
        else
          conn |> assign(:current_user, user)
        end
      else
        {:error, _reason} -> conn |> put_status(401) |> halt
        _ -> conn |> put_status(401) |> halt
      end
    end
  end
end
