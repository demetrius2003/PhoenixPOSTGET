defmodule Hello2Web.ApiController do
  use Hello2Web, :controller

  def apiPost(conn, _params) do
    "index"
  end
  def apiGet(conn, _params) do
    render(conn, "index.html")
  end
end