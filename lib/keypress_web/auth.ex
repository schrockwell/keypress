defmodule KeypressWeb.Auth do
  alias Phoenix.LiveView.Socket
  alias Plug.Conn

  def signed_in?(%Plug.Conn{} = conn) do
    !!Conn.get_session(conn, "authenticated")
  end

  def signed_in?(%Socket{} = socket) do
    socket.assigns.authenticated?
  end

  def sign_in(%Plug.Conn{} = conn) do
    if signed_in?(conn) do
      conn
    else
      Conn.put_session(conn, "authenticated", true)
    end
  end

  def sign_out(%Plug.Conn{} = conn) do
    Conn.clear_session(conn)
  end
end
