defmodule Monobanco.Repo do
  use Ecto.Repo,
    otp_app: :monobanco,
    adapter: Ecto.Adapters.Postgres
end
