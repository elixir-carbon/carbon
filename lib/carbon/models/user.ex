defmodule Carbon.User do
  use Ecto.Schema
  import Ecto.Changeset


  schema "users" do
    field :email, :string
    field :password_hash, :string
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
    
    timestamps
  end

  def changeset(:create, user, params) do
    user
    |> cast(params, [:email, :password])
    |> validate_required([:email, :password])
    |> validate_confirmation(:password)
    |> unique_constraint(:email)
    |> hash_password()
  end

  def changeset(:reset, user, params) do
    user
    |> cast(params, [:password])
    |> validate_required([:password])
    |> validate_confirmation(:password)
    |> hash_password()
  end

  def changeset(user, params \\ %{})
  def changeset(user, params) do
    user
    |> cast(params, [:email, :password_hash])
    |> validate_required([:email, :password_hash])
  end

  def hash_password(changeset) do
    password = get_change(changeset, :password)
    password_hash = Carbon.hash_password(password)
    put_change(changeset, :password_hash, password_hash)
  end
end