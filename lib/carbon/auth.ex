defmodule Carbon.Auth do
  import Plug.Conn
  import Phoenix.Controller
  import Carbon, only: [get_user: 1]

  def authenticate(conn, _) do
    case get_session(conn, :user_id) do
      nil -> conn |> redirect(to: "/login") |> halt
      user_id -> put_current_user(conn, user_id)
    end
  end

  # TODO: support for changesets
  def login(conn, user) do
    put_current_user(conn, user.id)
  end

  def fetch_current_user(conn, _) do
    case get_session(conn, :user_id) do
      nil -> conn
      user_id  -> assign(conn, :current_user, get_user(user_id))
    end
  end

  def put_current_user(conn, user_id) do
    put_session(conn, :user_id, user_id)
  end
end