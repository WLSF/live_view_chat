defmodule ElugceChat.Repo do
  use Ecto.Repo,
    otp_app: :elugce_chat,
    adapter: Ecto.Adapters.Postgres
end
