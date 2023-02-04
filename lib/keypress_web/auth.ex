defmodule KeypressWeb.Auth do
  import Plug.Conn

  def signed_in?(conn) do
    !!get_session(conn, "authenticated")
  end

  def sign_in(conn) do
    if signed_in?(conn) do
      conn
    else
      put_session(conn, "authenticated", true)
    end
  end

  def sign_out(conn) do
    clear_session(conn)
  end
end
