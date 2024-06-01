defmodule TrellixWeb.BoardsLive.Index do
  @moduledoc false
  use TrellixWeb, :live_view

  alias Trellix.Core.Board

  def mount(_params, _session, socket) do
    form =
      Board
      |> AshPhoenix.Form.for_create(:create, as: "board", actor: socket.assigns.current_user)
      |> to_form()

    boards = Board.all!(actor: socket.assigns.current_user)

    socket =
      socket
      |> stream(:boards, boards)
      |> assign(form: form)

    {:ok, socket}
  end

  def handle_event("create", %{"board" => params}, socket) do
    params = Map.put(params, "user_id", socket.assigns.current_user.id)

    case AshPhoenix.Form.submit(socket.assigns.form, params: params) do
      {:error, form} ->
        {:noreply, assign(socket, form: form)}

      {:ok, board} ->
        {:noreply, push_redirect(socket, to: ~p"/boards/#{board}")}
    end
  end

  def handle_event("delete", %{"id" => id}, socket) do
    board = Board.get!(id, actor: socket.assigns.current_user)

    board
    |> Board.delete(actor: socket.assigns.current_user)
    |> case do
      :ok ->
        {:noreply,
         socket
         |> stream_delete(:boards, board)
         |> LiveToast.put_toast(:info, "Board deleted")}

      e ->
        dbg(e)
        {:noreply, LiveToast.put_toast(socket, :error, "Something went wrong")}
    end
  end
end
