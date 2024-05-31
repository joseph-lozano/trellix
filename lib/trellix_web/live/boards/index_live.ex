defmodule TrellixWeb.BoardsLive.Index do
  @moduledoc false
  use TrellixWeb, :live_view

  alias Trellix.Core.Board

  def mount(_params, _session, socket) do
    form =
      Board
      |> AshPhoenix.Form.for_create(:create, as: "board", actor: socket.assigns.current_user)
      |> to_form()

    {:ok, assign(socket, form: form)}
  end

  def handle_event("create", %{"board" => params}, socket) do
    case AshPhoenix.Form.submit(socket.assigns.form, params: params) do
      {:error, form} ->
        {:noreply, assign(socket, form: form)}

      {:ok, board} ->
        {:noreply, push_redirect(socket, to: ~p"/boards/#{board}")}
    end
  end
end
