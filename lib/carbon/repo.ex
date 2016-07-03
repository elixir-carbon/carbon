defmodule Carbon.Repo do
  def insert(changeset) do
  	Carbon.repo.insert(changeset)
  end

  def get_by(struct, params) do
  	Carbon.repo.get_by(struct, params)
  end
end