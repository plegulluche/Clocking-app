defmodule Api.Repo.Migrations.CreateClocks do
  use Ecto.Migration

  def change do
    create table(:clocks, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :status, :boolean, default: true, null: false
      add :time, :utc_datetime
      add :user_id, references(:users, on_delete: :nilify_all, type: :binary_id)


      timestamps()
    end
  end
end
