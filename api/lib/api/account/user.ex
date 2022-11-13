defmodule Api.Account.User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @derive {Jason.Encoder, except: [:__meta__, :clocks, :workingtimes, :auth_tokens]}
  schema "users" do
    field :email, :string
    field :username, :string
    field :role, :string
    field :password, :string

    has_many :workingtimes, Api.Timer.Workingtime
    has_many :clocks, Api.Timer.Clock
    has_many :auth_tokens, Api.Authtokens.AuthToken
    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email, :role, :password])
    |> validate_required([:username, :email, :role, :password])
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
    |> put_password_hash()
  end

  defp put_password_hash(
         %Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset
       ) do
    change(changeset, password: Argon2.hash_pwd_salt(password))
  end

  defp put_password_hash(changeset), do: changeset
end
