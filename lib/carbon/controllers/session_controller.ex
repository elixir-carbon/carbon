defmodule Carbon.SessionController do
  use Phoenix.Controller
  alias Carbon.User
  alias Carbon.Repo

  def new(conn, _params) do
    changeset = User.changeset(:login, %User{})
    render(conn, "new.html", layout: false, changeset: changeset)
  end

  def create(conn, params) do
    changeset = User.changeset(:login, %User{}, params)
    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> login_user(user)
        |> redirect(to: "/")
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def login_user(conn, user) do
    conn
    |> Plug.Conn.put_session(:current_user, user)
  end
end