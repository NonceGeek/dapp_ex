defmodule AptosDappExWeb.UserSessionController do
  @moduledoc false

  use AptosDappExWeb, :controller

  alias AptosDappEx.Accounts
  alias AptosDappExWeb.UserAuth

  action_fallback AptosDappExWeb.FallbackController

  def create(conn, params) do
    with {:ok, user} <- Accounts.verify_wallet_address(params) do
      UserAuth.log_in_user(conn, user)
    end
  end

  def delete(conn, _params), do: UserAuth.log_out_user(conn)
end
