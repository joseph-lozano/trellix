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
    belongs_to :user, Trellix.Accounts.User do
      allow_nil? false
    end
  end

  postgres do
    table "boards"
    repo Trellix.Repo
  end

  actions do
    create :create do
      accept [:name, :color_hex, :user_id]
    end

    read :get do
      primary? true
      get? true
      argument :id, :uuid

      filter expr(id == ^arg(:id))
    end

    read :all

    destroy :destroy
  end

  code_interface do
    define :create
    define :get, args: [:id]
    define :all
    define :delete, action: :destroy
  end

  policies do
    policy action(:create) do
      authorize_if always()
    end

    policy action_type(:read) do
      authorize_if relates_to_actor_via(:user)
    end

    policy action_type(:destroy) do
      authorize_if relates_to_actor_via(:user)
    end
  end

  identities do
    identity :unique_name_per_user, [:name, :user_id], message: "A board with that name already exists"
  end
end
