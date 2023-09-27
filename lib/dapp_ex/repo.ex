defmodule DappEx.Repo do
  use Ecto.Repo,
    otp_app: :dapp_ex,
    adapter: Ecto.Adapters.Postgres
end
