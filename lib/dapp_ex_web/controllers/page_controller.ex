defmodule DappExWeb.PageController do
  use DappExWeb, :controller

  def home(conn, _params) do
    render(conn, :home, active_tab: :home)
  end
end
