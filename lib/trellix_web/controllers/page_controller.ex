defmodule TrellixWeb.PageController do
  use TrellixWeb, :controller

  def home(conn, _params) do
    if conn.assigns[:current_user] do
      redirect(conn, to: ~p"/boards")
    else
      render(conn, :home)
    end
  end
end
