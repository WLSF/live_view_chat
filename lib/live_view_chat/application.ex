defmodule LiveViewChat.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    Supervisor.start_link(children(), opts())
  end

  def children() do
    [
      {LiveViewChat.State, []},
      LiveViewChat.Repo,
      LiveViewChatWeb.Telemetry,
      {Phoenix.PubSub, name: LiveViewChat.PubSub},
      LiveViewChatWeb.Endpoint
    ]
  end

  def opts() do
    [strategy: :one_for_one, name: LiveViewChat.Supervisor]
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    LiveViewChatWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
