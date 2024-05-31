defmodule Trellix.Accounts.Secrets do
  @moduledoc false
  use AshAuthentication.Secret

  def secret_for([:authentication, :tokens, :signing_secret], Trellix.Accounts.User, _) do
    case Application.fetch_env(:trellix, TrellixWeb.Endpoint) do
      {:ok, endpoint_config} ->
        Keyword.fetch(endpoint_config, :secret_key_base)

      :error ->
        :error
    end
  end
end
