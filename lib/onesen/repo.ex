defmodule Onesen.Repo do
  use Ecto.Repo,
    otp_app: :onesen,
    adapter: Ecto.Adapters.Postgres
end
