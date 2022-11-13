defmodule Api.AuthtokensTest do
  use Api.DataCase

  alias Api.Authtokens

  describe "auth_tokens" do
    alias Api.Authtokens.AuthToken

    import Api.AuthtokensFixtures

    @invalid_attrs %{token: nil}

    test "list_auth_tokens/0 returns all auth_tokens" do
      auth_token = auth_token_fixture()
      assert Authtokens.list_auth_tokens() == [auth_token]
    end

    test "get_auth_token!/1 returns the auth_token with given id" do
      auth_token = auth_token_fixture()
      assert Authtokens.get_auth_token!(auth_token.id) == auth_token
    end

    test "create_auth_token/1 with valid data creates a auth_token" do
      valid_attrs = %{token: "some token"}

      assert {:ok, %AuthToken{} = auth_token} = Authtokens.create_auth_token(valid_attrs)
      assert auth_token.token == "some token"
    end

    test "create_auth_token/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Authtokens.create_auth_token(@invalid_attrs)
    end

    test "update_auth_token/2 with valid data updates the auth_token" do
      auth_token = auth_token_fixture()
      update_attrs = %{token: "some updated token"}

      assert {:ok, %AuthToken{} = auth_token} = Authtokens.update_auth_token(auth_token, update_attrs)
      assert auth_token.token == "some updated token"
    end

    test "update_auth_token/2 with invalid data returns error changeset" do
      auth_token = auth_token_fixture()
      assert {:error, %Ecto.Changeset{}} = Authtokens.update_auth_token(auth_token, @invalid_attrs)
      assert auth_token == Authtokens.get_auth_token!(auth_token.id)
    end

    test "delete_auth_token/1 deletes the auth_token" do
      auth_token = auth_token_fixture()
      assert {:ok, %AuthToken{}} = Authtokens.delete_auth_token(auth_token)
      assert_raise Ecto.NoResultsError, fn -> Authtokens.get_auth_token!(auth_token.id) end
    end

    test "change_auth_token/1 returns a auth_token changeset" do
      auth_token = auth_token_fixture()
      assert %Ecto.Changeset{} = Authtokens.change_auth_token(auth_token)
    end
  end
end
