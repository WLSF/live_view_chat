defmodule ElugceChatWeb.MessageLive.MessageComponent do
  use ElugceChatWeb, :live_component

  def render(assigns) do
    ~L"""
    <div class="media w-50 ml-auto mb-3">
      <div class="media-body">
        <div class="bg-primary rounded py-2 px-3 mb-2">
          <p class="text-small mb-0 text-white"><%= @message.text %></p>
        </div>
        <p class="small text-muted">12:00 PM | Aug 13</p>
      </div>
    </div>
    """
  end
end
