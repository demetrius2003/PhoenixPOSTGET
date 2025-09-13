defmodule Hello2Web.Plugs.RequestLogger do
  @moduledoc """
  Plug for logging API requests with timing and structured data.
  """

  import Plug.Conn
  require Logger

  def init(opts), do: opts

  def call(conn, _opts) do
    start_time = System.monotonic_time(:millisecond)
    
    conn
    |> put_private(:request_start_time, start_time)
    |> register_before_send(&log_request/1)
  end

  defp log_request(conn) do
    start_time = conn.private[:request_start_time]
    duration = System.monotonic_time(:millisecond) - start_time
    
    # Логируем только API запросы
    if String.starts_with?(conn.request_path, "/api") do
      Hello2.Logger.log_request(
        conn.method,
        conn.request_path,
        conn.params,
        conn.status,
        duration
      )
    end
    
    conn
  end
end
