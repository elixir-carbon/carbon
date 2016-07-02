defmodule Carbon.Routes do
	defmacro __using__(_) do
		quote do
			get "/login", Carbon.SessionController, :new
			post "/login", Carbon.SessionController, :create
			get "/register", Carbon.UserController, :new
			post "/register", Carbon.UserController, :create
		end
	end
end