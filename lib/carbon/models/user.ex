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

  @required_fields ~w(email password)
  @required_fields_reset ~w(password, password_confirmation)

  def changeset(action, user, params \\ %{})
  def changeset(:create, user, params) do
    user
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
    |> validate_confirmation(:password)
    |> hash_password()
  end

  def changeset(:update, user, params) do
    user
    |> cast(params, [:email, :password_hash])
    |> validate_required([:email, :password_hash])
  end

  def changeset(:reset, user, params) do
    user
    |> cast(params, @required_fields_reset)
    |> validate_required(@required_fields_reset)
    |> validate_confirmation(:password)
    |> hash_password()
  end

  def hash_password(changeset) do
    password = get_change(changeset, :password)
    password_hash = Carbon.hash_password(password)
    put_change(changeset, :password_hash, password_hash)
  end
end