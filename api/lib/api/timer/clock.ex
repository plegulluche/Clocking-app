defmodule Api.Timer.Clock do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "clocks" do
    field :status, :boolean, default: false
    field :time, :utc_datetime

    belongs_to :user, Api.Account.User, type: :binary_id

    timestamps()
  end

  @doc false
  def changeset(%__MODULE__{} = clock, attrs) do
    clock
    |> cast(attrs, [:status, :time, :user_id])
    |> validate_required([:status, :time, :user_id])
  end
end
