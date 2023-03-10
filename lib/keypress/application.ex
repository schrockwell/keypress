defmodule Keypress.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      KeypressWeb.Telemetry,
      # Start the Ecto repository
      Keypress.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Keypress.PubSub},
      # For rehydrading posts
      Keypress.BlogAdmin.DraftAgent,
      # Start the Endpoint (http/https)
      KeypressWeb.Endpoint
      # Start a worker by calling: Keypress.Worker.start_link(arg)
      # {Keypress.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Keypress.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    KeypressWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
