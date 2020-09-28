defmodule ElugceChatWeb.MessageLiveTest do
  use ElugceChatWeb.ConnCase

  import Phoenix.LiveViewTest

  alias ElugceChat.Chat

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
      {:ok, _index_live, html} = live(conn, Routes.message_index_path(conn, :index))

      assert html =~ "Listing Messages"
      assert html =~ message.author
    end

    test "saves new message", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.message_index_path(conn, :index))

      assert index_live |> element("a", "New Message") |> render_click() =~
               "New Message"

      assert_patch(index_live, Routes.message_index_path(conn, :new))

      assert index_live
             |> form("#message-form", message: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#message-form", message: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.message_index_path(conn, :index))

      assert html =~ "Message created successfully"
      assert html =~ "some author"
    end

    test "updates message in listing", %{conn: conn, message: message} do
      {:ok, index_live, _html} = live(conn, Routes.message_index_path(conn, :index))

      assert index_live |> element("#message-#{message.id} a", "Edit") |> render_click() =~
               "Edit Message"

      assert_patch(index_live, Routes.message_index_path(conn, :edit, message))

      assert index_live
             |> form("#message-form", message: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#message-form", message: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.message_index_path(conn, :index))

      assert html =~ "Message updated successfully"
      assert html =~ "some updated author"
    end

    test "deletes message in listing", %{conn: conn, message: message} do
      {:ok, index_live, _html} = live(conn, Routes.message_index_path(conn, :index))

      assert index_live |> element("#message-#{message.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#message-#{message.id}")
    end
  end

  describe "Show" do
    setup [:create_message]

    test "displays message", %{conn: conn, message: message} do
      {:ok, _show_live, html} = live(conn, Routes.message_show_path(conn, :show, message))

      assert html =~ "Show Message"
      assert html =~ message.author
    end

    test "updates message within modal", %{conn: conn, message: message} do
      {:ok, show_live, _html} = live(conn, Routes.message_show_path(conn, :show, message))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Message"

      assert_patch(show_live, Routes.message_show_path(conn, :edit, message))

      assert show_live
             |> form("#message-form", message: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#message-form", message: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.message_show_path(conn, :show, message))

      assert html =~ "Message updated successfully"
      assert html =~ "some updated author"
    end
  end
end
