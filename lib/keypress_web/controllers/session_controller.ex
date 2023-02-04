defmodule KeypressWeb.SessionController do
  use KeypressWeb, :controller

  plug KeypressWeb.RequireAuthenticatedPlug when action in [:show]

  def show(conn, _) do
    redirect(conn, to: ~p"/posts")
  end

  def delete(conn, _) do
    conn
    |> Auth.sign_out()
    |> redirect(to: ~p"/")
  end
end
