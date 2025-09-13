defmodule Hello2.Logger do
  @moduledoc """
  Structured logging module for the application.
  """

  require Logger

  @doc """
  Log API request with structured data.
  """
  def log_request(method, path, params, status, duration) do
    Logger.info("API Request", %{
      type: "api_request",
      method: method,
      path: path,
      params: params,
      status: status,
      duration_ms: duration,
      timestamp: DateTime.utc_now()
    })
  end

  @doc """
  Log API error with structured data.
  """
  def log_error(error, context \\ %{}) do
    Logger.error("API Error", %{
      type: "api_error",
      error: inspect(error),
      context: context,
      timestamp: DateTime.utc_now()
    })
  end

  @doc """
  Log database operation.
  """
  def log_db_operation(operation, table, duration, result) do
    Logger.info("Database Operation", %{
      type: "db_operation",
      operation: operation,
      table: table,
      duration_ms: duration,
      result: result,
      timestamp: DateTime.utc_now()
    })
  end

  @doc """
  Log user action.
  """
  def log_user_action(action, user_id, details \\ %{}) do
    Logger.info("User Action", %{
      type: "user_action",
      action: action,
      user_id: user_id,
      details: details,
      timestamp: DateTime.utc_now()
    })
  end

  @doc """
  Log validation error.
  """
  def log_validation_error(changeset, context \\ %{}) do
    errors = 
      changeset.errors
      |> Enum.map(fn {field, {message, _}} -> 
        %{field: field, message: message}
      end)

    Logger.warning("Validation Error", %{
      type: "validation_error",
      errors: errors,
      context: context,
      timestamp: DateTime.utc_now()
    })
  end

  @doc """
  Log performance metrics.
  """
  def log_performance(operation, duration, metadata \\ %{}) do
    Logger.info("Performance", %{
      type: "performance",
      operation: operation,
      duration_ms: duration,
      metadata: metadata,
      timestamp: DateTime.utc_now()
    })
  end
end
