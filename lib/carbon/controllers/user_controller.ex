defmodule Carbon.UserController do
  use Phoenix.Controller
  import Carbon
  alias Carbon.User

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    user = User.changeset(:create, %User{}, user_params)
    case repo.insert(user) do
      {:ok, _user} ->
        # maybe send registration email
        conn
        |> put_flash(:info, "You have registered successfully.")
        |> redirect(to: "/login")
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, _params) do
    render(conn, "show.html")
  end
end