defmodule Carbon.Auth do
  import Plug.Conn
  import Phoenix.Controller

  def authenticate(conn, _) do
    case get_session(conn, :user_id) do
      nil -> 
        conn
        |> redirect(to: "/login")
        |> halt()
      user_id -> put_current_user(conn, user_id)
    end
  end

  def login(conn, user) do
    put_session(conn, :user_id, user.id)
  end

  def put_current_user(conn, user_id) do
    user = Carbon.repo.get(Carbon.User, user_id)

    conn
    |> assign(:current_user, user)
  end
end