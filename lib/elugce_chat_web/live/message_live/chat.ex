defmodule ElugceChatWeb.MessageLive.Chat do
  use ElugceChatWeb, :live_view

  alias ElugceChat.State

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(_params, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))}
  end

  defp apply_action(socket, :create, params) do
    State.push(10)
  end

  defp page_title(:index), do: ""
end
