defmodule Api.Authtokens.AuthToken do
  use Ecto.Schema
  import Ecto.Changeset

  schema "auth_tokens" do
    field :token, :string
    # field :user_id, :id
    belongs_to :user, Api.Account.User, type: :binary_id

    timestamps()
  end

  @doc false
  def changeset(auth_token, attrs) do
    auth_token
    |> cast(attrs, [:token])
    |> validate_required([:token])
  end
end
