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
        get "/register", Carbon.UserController, :new
        post "/register", Carbon.UserController, :create
        get "/password/reset", Carbon.PasswordController, :new
        get "/password/new", Carbon.PasswordController, :new
        post "/password/create", Carbon.PasswordController, :create
        get "/password/:token/edit", Carbon.PasswordController, :edit
        post "/password/update", Carbon.PasswordController, :update
      end

      scope "/" do
        pipe_through [:browser, :auth]

        get "/profile", Carbon.UserController, :show
        delete "/logout", Carbon.SessionController, :delete
      end
    end
  end
end