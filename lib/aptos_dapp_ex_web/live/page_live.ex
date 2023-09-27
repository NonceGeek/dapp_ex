defmodule AptosDappExWeb.PageLive do
  use AptosDappExWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     assign(socket,
       modal: false,
       slide_over: false,
       pagination_page: 1,
       active_tab: :live
     )}
  end

  @impl true
  def handle_params(params, _uri, socket) do
    case socket.assigns.live_action do
      :index ->
        {:noreply, assign(socket, modal: false, slide_over: false)}

      :modal ->
        {:noreply, assign(socket, modal: params["size"])}

      :slide_over ->
        {:noreply, assign(socket, slide_over: params["origin"])}

      :pagination ->
        {:noreply, assign(socket, pagination_page: String.to_integer(params["page"]))}
    end
  end

  @impl true
  def render(assigns) do
    ~H"""
    
      <.container class="mt-10">
        Aptos Dapp Ex is  here.
      </.container>

    """
  end

  @impl true
  def handle_event("close_modal", _, socket) do
    {:noreply, socket}
  end

  def handle_event("close_slide_over", _, socket) do
    {:noreply, socket}
  end
end
