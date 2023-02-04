defmodule KeypressWeb.RequireAuthenticatedPlug do
  @behaviour Plug

  alias KeypressWeb.Auth

  @impl true
  def init(_), do: []

  @impl true
  def call(conn, _) do
    conn
    |> Plug.BasicAuth.basic_auth(credentials())
    |> case do
      %{status: nil, halted: false} = conn ->
        # Successful login
        Auth.sign_in(conn)

      %{status: 401, halted: true} = conn ->
        # Login challenge
        conn
    end
  end

  defp credentials do
    [username: "", password: System.fetch_env!("AUTHOR_PASSWORD")]
  end
end
