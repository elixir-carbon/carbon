defmodule <%= base %>.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :password_hash, :string
      add :password_reset_token, :string

      timestamps()
    end
    create unique_index(:users, [:email])
    create index(:users, [:password_reset_token])
  end
end
