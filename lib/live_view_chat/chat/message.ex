defmodule LiveViewChat.Chat.Message do
  use Ecto.Schema
  import Ecto.Changeset

  schema "messages" do
    field :author, :string, default: "WLSF"
    field :text, :string

    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:text, :author])
    |> validate_required([:text, :author])
  end
end
