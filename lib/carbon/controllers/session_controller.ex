defmodule Carbon.SessionController do
  use Carbon.Web, :controller
  import Carbon

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
    user = repo.get_by(model, email: email)
    if (user && verify_password(password, user.password_hash)) do
      conn
      |> Carbon.Auth.login(user)
      |> redirect(to: "/")
    else
      # dummy check to time responses
      # always returns false
      verify_password(password)
      render_with_error(conn)
    end
  end

  defp render_with_error(conn) do
    conn
    |> put_flash(:error, "Invalid email or password")
    |> render("new.html")
  end

  def delete(conn, _params) do
    conn
    |> Carbon.Auth.logout
    |> redirect(to: "/login")
  end
end