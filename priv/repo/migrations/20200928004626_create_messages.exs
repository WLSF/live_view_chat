defmodule LiveViewChat.Repo.Migrations.CreateMessages do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :text, :string
      add :author, :string

      timestamps()
    end

  end
end
