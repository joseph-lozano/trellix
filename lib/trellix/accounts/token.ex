defmodule Trellix.Accounts.Token do
  @moduledoc false
  use Ash.Resource,
    domain: Trellix.Accounts,
    data_layer: AshPostgres.DataLayer,
    authorizers: [Ash.Policy.Authorizer],
    extensions: [AshAuthentication.TokenResource]

  postgres do
    table "tokens"
    repo Trellix.Repo
  end

  policies do
    bypass AshAuthentication.Checks.AshAuthenticationInteraction do
      authorize_if always()
    end
  end
end
