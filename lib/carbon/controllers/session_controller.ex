defmodule Carbon.SessionController do
  use Carbon.Web, :controller

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, %{"login" => %{"email" => "", "password" => _}}) do
    render(conn, "new.html", error: true)
  end

  def create(conn, %{"login" => %{"email" => _, "password" => ""}}) do
    render(conn, "new.html", error: true)
  end

  def create(conn, %{"login" => %{"email" => email, "password" => password}}) do
    case Carbon.attempt(email, password) do
      # TODO: implment flash messages
      nil -> render(conn, "new.html", error: true)
      false -> render(conn, "new.html", error: true)
      user -> 
        conn
        |> Carbon.Auth.login(user)
        |> redirect(to: "/")
    end
  end

  def delete(conn, _params) do
    conn
    |> put_session(:user_id, nil)
    |> redirect(to: "/login")
  end
end