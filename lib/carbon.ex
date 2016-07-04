defmodule Carbon do
  import Ecto.Changeset
  alias Ecto.Changeset

  def attempt(email, password) do
    user = repo.get_by(model(), email: email)
    if (user && verify_password(password, user.password_hash)) do
      user
    else
      nil
    end
  end
  def attempt(_), do: nil

  def hash_password(%Changeset{} = changeset, password) do
    put_change(changeset, :password_hash, hash_password(password))
  end

  def hash_password(%Changeset{} = changeset) do
    case get_change(changeset, :password) do
      nil -> changeset
      password -> hash_password(changeset, password)
    end
  end

  def hash_password(password) do
    Comeonin.Bcrypt.hashpwsalt(password)
  end

  def verify_password(password, hash) do
    Comeonin.Bcrypt.checkpw(password, hash)
  end

  def get_user(user_id) do
    repo.get(model(), user_id)
  end

  def repo do
    Application.get_env(:carbon, :repo)
  end

  def model do
    Application.get_env(:carbon, :model, Carbon.User)
  end
end