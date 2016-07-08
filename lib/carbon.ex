defmodule Carbon do
  def hash_password(password) do
    Comeonin.Bcrypt.hashpwsalt(password)
  end

  def verify_password(password, hash) do
    Comeonin.Bcrypt.checkpw(password, hash)
  end

  def verify_password(_) do
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
