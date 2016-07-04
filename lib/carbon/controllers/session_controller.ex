defmodule Carbon.SessionController do
  use Carbon.Web, :controller

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, %{"login" => %{"email" => "", "password" => _}}) do
    render_with_error(conn)
  end

  def create(conn, %{"login" => %{"email" => _, "password" => ""}}) do
    render_with_error(conn)
  end

  def create(conn, %{"login" => %{"email" => email, "password" => password}}) do
    case Carbon.attempt(email, password) do
      user when is_map(user) -> login_user(conn, user)
      _ -> render_with_error(conn)
    end
  end

  defp render_with_error(conn) do
    conn
    |> put_flash(:error, "Invalid email or password")
    |> render("new.html")
  end

  defp login_user(conn, user) do
    conn
    |> Carbon.Auth.login(user)
    |> redirect(to: "/")
  end

  def delete(conn, _params) do
    conn
    |> Carbon.Auth.logout
    |> redirect(to: "/login")
  end
end