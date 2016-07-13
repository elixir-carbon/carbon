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
end