defmodule AptosDappEx.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      AptosDappExWeb.Telemetry,
      # Start the Ecto repository
      AptosDappEx.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: AptosDappEx.PubSub},
      # Start Finch
      {Finch, name: AptosDappEx.Finch},
      # Start the Endpoint (http/https)
      AptosDappExWeb.Endpoint
      # Start a worker by calling: AptosDappEx.Worker.start_link(arg)
      # {AptosDappEx.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: AptosDappEx.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    AptosDappExWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
