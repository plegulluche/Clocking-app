defmodule Api.Account do
  @moduledoc """
  The Account context.
  """

  import Ecto.Query, warn: false
  alias Api.Repo

  alias Api.Account.User
  alias Argon2

  def login(email, plain_text_password) do
    query = from(u in User, where: u.email == ^email)

    case Repo.one(query) do
      nil ->
        Argon2.no_user_verify()
        {:error, :invalid_credentials}

      user ->
        if Argon2.verify_pass(plain_text_password, user.password) do
          {:ok, user}
        else
          {:error, :invalid_credentials}
        end
    end
  end

  def test_id(id) do
    query = from(u in User, where: u.id == ^id)
    case Repo.one(query) do
      nil ->
        {:error, :invalid_credentials}

      user ->
        {:ok, user}
    end
  end

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  @spec list_users :: list()
  def list_users do
    Repo.all(User)
  end

  # @spec get_user_by_id(map()) :: list()
  def get_user_by_id(%{"id" => id}) do
    User
    |> where([u], u.id == ^id)
    |> limit(1)
    |> Repo.one()
  end

  @spec get_user(map()) :: list()
  def get_user(%{"email" => email, "username" => username}) do
    User
    |> where([u], u.email == ^email)
    |> where([u], u.username == ^username)
    |> limit(1)
    |> Repo.one()
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

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

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    IO.puts "++INSIDE DELETE USER CONTEXT++"
    IO.inspect(user)
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{data: %User{}}

  """
  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end
end
