defmodule Trellix.Core do
  @moduledoc false
  use Ash.Domain

  resources do
    resource Trellix.Core.Board
  end
end
