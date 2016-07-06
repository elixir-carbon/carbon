defmodule Carbon.Routes do
  defmacro __using__(_) do
    quote do
      import Carbon.Auth

      pipeline :auth do
        plug :authenticate
      end

      scope "/" do
        pipe_through [:browser] 

        get "/login", Carbon.SessionController, :new
        post "/login", Carbon.SessionController, :create
        get "/password/forgot", Carbon.PasswordController, :forgot
        post "/password/reset", Carbon.PasswordController, :reset
        get "/password/new", Carbon.PasswordController, :new
        post "/password/create", Carbon.PasswordController, :create
        get "/register", Carbon.UserController, :new
        post "/register", Carbon.UserController, :create
      end

      scope "/" do
        pipe_through [:browser, :auth]

        get "/profile", Carbon.UserController, :show
        delete "/logout", Carbon.SessionController, :delete
      end
    end
  end
end