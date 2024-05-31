defmodule Trellix.Accounts do
  @moduledoc false
  use Ash.Domain

  resources do
    resource Trellix.Accounts.User
    resource Trellix.Accounts.Token
  end
end
