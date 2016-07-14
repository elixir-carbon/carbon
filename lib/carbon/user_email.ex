defmodule Carbon.UserEmail do
  import Swoosh.Email

  def welcome(user) do
    new
    |> to({"", user.email})
    |> from({"Carbon App", "noreply@example.com"})
    |> subject("Hello!")
    |> html_body("<h1>Hello #{user.email}</h1>")
    |> text_body("Hello #{user.email}\n")
  end

  def password_reset(user) do
    reset_url = "http://localhost:4000/password/#{user.password_reset_token}/edit"
    template = """
    Please click here to <a href="#{reset_url}">reset</a> your password.
    """

    new
    |> to({"", user.email})
    |> from({"Carbon App", "noreply@example.com"})
    |> subject("Confirm your account")
    |> html_body(template)
  end

  def password_update(user) do
    template = """
    Hi, Your password have been updated successfully.
    """

    new
    |> to({"", user.email})
    |> from({"Carbon App", "noreply@example.com"})
    |> subject("Password updated.")
    |> html_body(template)
  end
end