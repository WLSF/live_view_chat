defmodule LiveViewChat.Repo do
  use Ecto.Repo,
    otp_app: :live_view_chat,
    adapter: Ecto.Adapters.Postgres
end
