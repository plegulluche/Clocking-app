defmodule Api.Directory.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :username, :string
    # has_one :clock, Api.Directory.Clock
    # has_one :workingtime, Api.Directory.Workingtime

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :username])
    |> validate_required([:email, :username])
    |> validate_format(:email, ~r/@/)
  end
end
