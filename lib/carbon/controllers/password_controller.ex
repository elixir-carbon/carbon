defmodule Carbon.PasswordController do
  use Carbon.Web, :controller
  import Carbon
  alias Carbon.User

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, %{"user" => %{"email" => ""}}) do
    conn
    |> put_flash(:error, "We could not find that email, Sorry!")
    |> render("new.html")
  end

  def create(conn, %{"user" => %{"email" => email} = params}) do
    user = repo.get_by(User, email: email)
    if user do
      changeset = User.changeset(user, params)
      case repo.update(changeset) do
        {:ok, user} -> Carbon.Mailer.send_password_reset(user)
        {:error, _changeset} -> :error # I don't know maybe, do nothing
      end
    end
    
    conn
    |> put_flash(:info, "Please check your email to reset your password.")
    |> redirect(to: "/")
  end

  def edit(conn, _params) do
    changeset = User.changeset(:reset, %User{})
    render(conn, "edit.html", changeset: changeset)
  end

  def update(conn, %{"user" => %{"token" => token} = params}) do
    user = repo.get_by!(User, token: token)
    changeset = User.changeset(:reset, user, params)

    case repo.update(changeset) do
      {:ok, _user} ->
        conn
        |> put_flash(:info, "Your password has been changed successfully.")
        |> redirect(to: "/login")
      {:error, changeset} ->
        render(conn, "edit.html", changeset: changeset)
    end
  end
end