defmodule KeypressWeb.PageController do
  use KeypressWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
