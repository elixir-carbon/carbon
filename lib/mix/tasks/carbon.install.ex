defmodule Mix.Tasks.Carbon.Install do
  use Mix.Task

  @shortdoc "Generates a migration for Carbon"

  @moduledoc """
  Generates a migration and updated database.

      mix carbon.install
  """
  def run(args) do
    {opts, args, _} = OptionParser.parse(args, switches: [migrate: :boolean])
    module = validate(args)
    binding = Mix.Phoenix.inflect(module)

    Mix.Phoenix.copy_from [".", :carbon], "priv/templates/carbon.gen.migration", "", binding, [
      {:eex, "migration.exs", "priv/repo/migrations/#{timestamp()}_create_user.exs"},
    ]

    if opts[:migrate] do
      Mix.Task.run "ecto.create"
      Mix.Task.run "ecto.migrate"
    end
  end

  def validate([singular | _]), do: singular
  def validate([]), do: "User"

  defp timestamp do
    {{y, m, d}, {hh, mm, ss}} = :calendar.universal_time()
    "#{y}#{pad(m)}#{pad(d)}#{pad(hh)}#{pad(mm)}#{pad(ss)}"
  end

  defp pad(i) when i < 10, do: << ?0, ?0 + i >>
  defp pad(i), do: to_string(i)
end
