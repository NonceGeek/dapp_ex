defmodule DappEx.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      DappExWeb.Telemetry,
      # Start the Ecto repository
      DappEx.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: DappEx.PubSub},
      # Start Finch
      {Finch, name: DappEx.Finch},
      # Start the Endpoint (http/https)
      DappExWeb.Endpoint
      # Start a worker by calling: DappEx.Worker.start_link(arg)
      # {DappEx.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: DappEx.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    DappExWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
