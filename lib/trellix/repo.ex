defmodule Trellix.Repo do
  use AshPostgres.Repo, otp_app: :trellix

  def installed_extensions do
    ["uuid-ossp", "citext", "ash-functions"]
  end
end
