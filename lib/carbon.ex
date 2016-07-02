defmodule Carbon do
	use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    # Define workers and child supervisors to be supervised
    children = [
      # Starts a worker by calling: Foo.Worker.start_link(arg1, arg2, arg3)
      # worker(Foo.Worker, [arg1, arg2, arg3]),
      worker(Carbon.Repo, []),
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Foo.Supervisor]
    Supervisor.start_link(children, opts)
  end
	
	def hash_password(password) do
    Comeonin.hashpwsalt(password)
	end

	def verify_password(password, hash) do
    Comeonin.checkpw(password, hash)
	end

	def say_hello do
		"hello from carbon!"
	end
end