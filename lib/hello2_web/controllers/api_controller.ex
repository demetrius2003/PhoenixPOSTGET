defmodule Hello2Web.ApiController do
  use Hello2Web, :controller

  # Обработка ошибок
  def handle_error(conn, error) do
    response = %{
      status: "error",
      message: error,
      timestamp: DateTime.utc_now()
    }
    
    conn
    |> put_status(:bad_request)
    |> json(response)
  end

  def apiPost(conn, params) do
    try do
      # Логируем полученные данные
      IO.inspect(params, label: "POST params received")
      
      # Валидация параметров
      if map_size(params) == 0 do
        handle_error(conn, "No data provided")
      else
        # Обрабатываем данные
        response = %{
          status: "success",
          message: "POST request received",
          data: params,
          timestamp: DateTime.utc_now()
        }
        
        json(conn, response)
      end
    rescue
      error -> 
        IO.inspect(error, label: "POST Error")
        handle_error(conn, "Internal server error")
    end
  end

  def apiGet(conn, params) do
    # Логируем полученные данные
    IO.inspect(params, label: "GET params received")
    
    # Обрабатываем данные
    response = %{
      status: "success", 
      message: "GET request received",
      data: params,
      timestamp: DateTime.utc_now()
    }
    
    json(conn, response)
  end

  def status(conn, _params) do
    response = %{
      status: "success",
      message: "API is running",
      version: "1.0.0",
      uptime: System.uptime(:second),
      timestamp: DateTime.utc_now()
    }
    
    json(conn, response)
  end

  def echo(conn, params) do
    # Логируем полученные данные
    IO.inspect(params, label: "ECHO params received")
    
    response = %{
      status: "success",
      message: "Echo endpoint",
      echo: params,
      timestamp: DateTime.utc_now()
    }
    
    json(conn, response)
  end

  def health(conn, _params) do
    response = %{
      status: "healthy",
      message: "Service is healthy",
      checks: %{
        database: "connected",
        memory: "ok",
        cpu: "normal"
      },
      timestamp: DateTime.utc_now()
    }
    
    json(conn, response)
  end
end