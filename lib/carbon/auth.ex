defmodule Carbon.Auth do
  import Plug.Conn
  import Phoenix.Controller
  import Carbon, only: [get_user: 1]

  def init(opts), do: opts

  def call(conn, opts) do
    authenticate(conn, opts)
  end

  def authenticate(conn, _) do
    case user_logged_in?(conn) do
      nil -> conn |> redirect(to: "/login") |> halt
      user_id -> put_current_user(conn, user_id)
    end
  end

  def fetch_current_user(conn, _) do
    case user_logged_in?(conn) do
      nil -> conn
      user_id  -> put_current_user(conn, user_id)
    end
  end

  def put_current_user(conn, user_id) do
    #  avoid extra calls to the database 
    # if the user is already in the session
    case conn.assigns[:current_user] do
      nil -> assign(conn, :current_user, get_user(user_id))
      _user -> conn
    end
  end

  def user_logged_in?(conn) do
    get_session(conn, :user_id)
  end

  # TODO: support for changesets
  def login(conn, user) when is_map(user) do
    conn
    |> put_session(:user_id, user.id)
    |> assign(:user_id, user.id)
  end

  def login(conn, user) when is_integer(user) do
    conn
    |> put_session(:user_id, user)
    |> assign(:user_id, user)
  end

  def login(conn, user) when is_map(user) do
    conn
    |> put_session(:user_id, user.id)
    |> assign(:user_id, user.id)
  end

  def logout(conn) do
    conn
    |> delete_session(:user_id)
    |> assign(:user_id, nil)
  end
end