defmodule LiveViewChatWeb.MessageLiveTest do
  use LiveViewChatWeb.ConnCase

  import Phoenix.LiveViewTest

  alias LiveViewChat.Chat

  @create_attrs %{author: "some author", text: "some text"}

  defp fixture(:message) do
    {:ok, message} = Chat.create_message(@create_attrs)
    message
  end

  defp create_message(_) do
    message = fixture(:message)
    %{message: message}
  end

  describe "Index" do
    setup [:create_message]

    test "lists all messages", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, Routes.message_path(conn, :index))

      assert html =~ "Chat"
      assert html =~ "some text"
    end
  end
end
