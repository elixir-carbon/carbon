defmodule Carbon do
  def password_hash(password) do
    Comeonin.Bcrypt.hashpwsalt(password)
  end

  def password_verify(password, hash) do
    Comeonin.Bcrypt.checkpw(password, hash)
  end

  def password_verify(_) do
    Comeonin.Bcrypt.dummy_checkpw
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
