defmodule TrellixWeb.BoardsLive.Show do
  @moduledoc false
  use TrellixWeb, :live_view

  alias Trellix.Core.Board

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_params(%{"board_id" => board_id}, _uri, socket) do
    board_id
    |> Board.get(actor: socket.assigns.current_user)
    |> case do
      {:ok, board} ->
        {:noreply, assign(socket, board: board)}

      {:error, _} ->
        raise %Ecto.NoResultsError{message: "No board found with id #{board_id}"}
    end
  end
end
