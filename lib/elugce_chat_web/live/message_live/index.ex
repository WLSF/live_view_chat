defmodule ElugceChatWeb.MessageLive.Index do
  use ElugceChatWeb, :live_view

  alias ElugceChat.State
  alias ElugceChat.Chat
  alias ElugceChat.Chat.Message

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :messages, list_messages())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Message")
    |> assign(:message, Chat.get_message!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Message")
    |> assign(:message, %Message{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Messages")
    |> assign(:message, nil)
  end

  @impl true
  def handle_event("create", %{"nil" => %{"text" => _} = message}, socket) do
    with {:ok, %Message{}} <- Chat.create_message(message) do
      IO.inspect(list_messages())
      {:noreply, assign(socket, :messages, list_messages())}
    end
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    message = Chat.get_message!(id)
    {:ok, _} = Chat.delete_message(message)

    {:noreply, assign(socket, :messages, list_messages())}
  end

  defp list_messages do
    Chat.list_messages()
  end
end
