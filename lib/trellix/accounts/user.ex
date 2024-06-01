defmodule Trellix.Accounts.User do
  @moduledoc false
  use Ash.Resource,
    domain: Trellix.Accounts,
    data_layer: AshPostgres.DataLayer,
    authorizers: [Ash.Policy.Authorizer],
    extensions: [AshAuthentication]

  attributes do
    uuid_primary_key :id

    attribute :email, :ci_string do
      allow_nil? false
      public? true
    end

    attribute :hashed_password, :string, allow_nil?: false, sensitive?: true
  end

  authentication do
    strategies do
      password :password do
        identity_field :email
      end
    end

    tokens do
      enabled? true
      token_resource Trellix.Accounts.Token
      signing_secret Trellix.Accounts.Secrets
    end
  end

  postgres do
    table "users"
    repo Trellix.Repo
  end

  identities do
    identity :unique_email, [:email]
  end

  actions do
    defaults [:read]
  end

  policies do
    bypass AshAuthentication.Checks.AshAuthenticationInteraction do
      authorize_if always()
    end
  end
end
