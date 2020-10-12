defmodule LiveViewChatWeb.MessageLiveTest do
  use LiveViewChatWeb.ConnCase

  import Phoenix.LiveViewTest

  alias LiveViewChat.Chat

  @create_attrs %{author: "some author", text: "some text"}
  @update_attrs %{author: "some updated author", text: "some updated text"}
  @invalid_attrs %{author: nil, text: nil}

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

    test "lists all messages", %{conn: conn, message: message} do
      {:ok, _index_live, html} = live(conn, Routes.message_path(conn, :index))

      assert html != nil
    end
  end
end
