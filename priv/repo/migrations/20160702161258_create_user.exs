defmodule Carbon.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
  	create table(:users) do
  	  add :email, :string
  	  add :password_hash, :string
      add :password_reset_token, :string

  	  timestamps
  	end
  	create index(:users, [:email])
  end
end
