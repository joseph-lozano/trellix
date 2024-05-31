defmodule Trellix.Core.Board do
  @moduledoc false
  use Ash.Resource,
    domain: Trellix.Core,
    data_layer: AshPostgres.DataLayer,
    authorizers: [Ash.Policy.Authorizer]

  attributes do
    uuid_primary_key :id

    attribute :name, :string do
      allow_nil? false
      constraints min_length: 3
    end

    attribute :color_hex, :string do
      constraints match: ~r/^#([0-9a-fA-F]{3}|[0-9a-fA-F]{6})$/
    end

    create_timestamp :created_at
    update_timestamp :updated_at
  end

  relationships do
    belongs_to :user, Trellix.Accounts.User
  end

  postgres do
    table "boards"
    repo Trellix.Repo
  end

  actions do
    default_accept [:name, :color_hex]
    defaults [:create]
  end

  code_interface do
    define :create
  end

  policies do
    policy action(:create) do
      authorize_if always()
    end
  end

  identities do
    identity :unique_name_per_user, [:user_id, :name], message: "A board with that name already exists"
  end
end
