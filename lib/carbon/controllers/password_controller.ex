defmodule Carbon.PasswordController do
  use Carbon.Web, :controller
  import Carbon
  alias Carbon.User

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, %{"user" => %{"email" => ""}}) do
    render_with_error(conn)
  end
  def create(conn, %{"user" => %{"email" => email}}) do
    user = repo.get_by(User, )
    case repo.insert(params) do
      {:ok, _user} ->
        conn
        |> put_flash(:info, "Please check your email and follow the instructions.")
        |> redirect(to: "/")
      {:error, _changeset} ->
        render_with_error(conn)
    end
  end

  defp render_with_error(conn) do
    conn
    |> put_flash(:error, "Please provide a valid email.")
    |> render("new.html")
  end

  def edit(conn, _params) do
    render(conn, "edit.html")
  end

  def update(conn, %{"user" => params}) do
    user = repo.get_by!(User, token: params["token"])
    changeset = User.changeset(:update, user, params)

    case repo.update(changeset) do
      {:ok, _user} ->
        conn
        |> put_flash(:info, "Your password has been changed successfully.")
        |> redirect(to: "/login")
      {:error, _changeset} ->
        render(conn, "edit.html")
    end
  end
end
