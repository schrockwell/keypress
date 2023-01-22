defmodule Keypress.Repo do
  use Ecto.Repo,
    otp_app: :keypress,
    adapter: Ecto.Adapters.Postgres
end
