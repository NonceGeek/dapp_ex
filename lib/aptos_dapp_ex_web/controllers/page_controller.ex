defmodule AptosDappExWeb.PageController do
  use AptosDappExWeb, :controller

  def home(conn, _params) do
    render(conn, :home, active_tab: :home)
  end
end
