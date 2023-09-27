defmodule DappExWeb.WalletLive do
  @moduledoc false

  use DappExWeb, :live_view

  @impl true
  def mount(_, session, socket) do
    {:ok,
     socket
     |> assign_new(:connected, fn -> false end)
     |> assign_new(:id, fn -> session["id"] end)
     |> assign_new(:current_wallet_address, fn -> nil end)
     |> assign_new(:wallet_type, fn -> nil end)}
  end

  @impl true
  def handle_event("wallet-info", %{"address" => address, "walletType" => wallet_type}, socket) do
    connected = if address, do: true, else: false

    {:noreply,
     socket
     |> assign(:current_wallet_address, address)
     |> assign(:connected, connected)
     |> assign(:wallet_type, wallet_type)}
  end

  @impl true
  def handle_event("connect_petra", _, socket) do
    {:noreply, push_event(socket, "connect-petra", %{})}
  end

  @impl true
  def handle_event("connect_martian", _, socket) do
    {:noreply, push_event(socket, "connect-martian", %{})}
  end

  @impl true
  def handle_event("connect_starmask", _, socket) do
    {:noreply, push_event(socket, "connect-starmask", %{})}
  end

  @impl true
  def handle_event("disconnect", _, socket) do
    {:noreply, push_event(socket, "disconnect", %{})}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div id={@id} phx-hook="Wallet" class="space-y-2 flex flex-col m-2 justify-center ">
      <h5 class="font-bold text-lg text-center p-2">Collect Wallet</h5>

      <button class="text-white bg-blue-700 hover:bg-blue-800 focus:outline-none focus:ring-4 focus:ring-blue-300 font-medium rounded-full text-sm px-5 py-2.5 text-center mr-2 mb-2 dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800" phx-click="connect_petra">Connect Petra</button>
    </div>
    """
  end
end
