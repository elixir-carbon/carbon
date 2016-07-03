defmodule Carbon.User do
  use Ecto.Schema
  import Ecto
  import Ecto.Changeset
  import Ecto.Query

  schema "users" do
    field :email, :string
    field :password_hash, :string
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
    
    timestamps
  end

  def changeset(action, user, params \\ %{})
  def changeset(:create, user, params) do
    user
    |> cast(params, [:email, :password])
    |> validate_required([:email, :password])
    |> validate_confirmation(:password)
    |> Carbon.hash_password
  end

  def changeset(:login, user, params) do
    user
    |> cast(params, [:email, :password])
    |> validate_required([:email, :password])
  end
end