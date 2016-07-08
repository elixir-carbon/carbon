defmodule Carbon.Mixfile do
  use Mix.Project
  @repo_url "http://github.com/elixirdrops/carbon"
  @version "0.1.2"

  def project do
    [app: :carbon,
     version: @version,
     elixir: "~> 1.3",
     package: package(),
     compilers: [:phoenix, :gettext] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     description: "User library for phoenix and elixir.",
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :phoenix, :phoenix_html]]
  end

  def package do
    [maintainers: ["Al-Razi"],
     licenses: ["Apache 2.0"],
     links: %{"GitHub" => @repo_url},
     files: ~w(lib lib priv test web mix.exs *.md)]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [{:phoenix, "~> 1.2"},
     {:phoenix_html, "~> 2.6"},
     {:phoenix_ecto, "~> 3.0"},
     {:comeonin, "~> 2.5"},
     {:gettext, "~> 0.11"}]
  end
end
