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
      changeset = User.changeset(:password_reset, user, params)
      case repo.update(changeset) do
        {:ok, user} -> 
          Carbon.UserEmail.password_reset(user) |> Carbon.Mailer.deliver
        {:error, _changeset} -> 
          :error 
      end
    end

    conn
    |> put_flash(:info, "Please check your email to reset your password.")
    |> redirect(to: "/")
  end

  def edit(conn, %{"password_reset_token" => token} = params) do
    user = repo.get_by!(User, password_reset_token: token)
    changeset = User.changeset(user, params)
    render(conn, "edit.html", changeset: changeset)
  end

  def update(conn, %{"user" => %{"password_reset_token" => token} = params}) do
    user = repo.get_by!(User, password_reset_token: token)
    changeset = User.changeset(:password_update, user, params)

    case repo.update(changeset) do
      {:ok, user} ->
        Carbon.UserEmail.password_update(user) |> Carbon.Mailer.deliver
        conn
        |> put_flash(:info, "Your password has been changed successfully.")
        |> redirect(to: "/login")
      {:error, changeset} ->
        render(conn, "edit.html", changeset: changeset)
    end
  end
end