defmodule AptosDappEx.Repo do
  use Ecto.Repo,
    otp_app: :aptos_dapp_ex,
    adapter: Ecto.Adapters.Postgres
end
