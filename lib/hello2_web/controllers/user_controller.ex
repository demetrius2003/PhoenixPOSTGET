defmodule Hello2Web.UserController do
  use Hello2Web, :controller
  alias Hello2.Users
  alias Hello2.Users.User
  alias Hello2.Logger

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

  def handle_validation_error(conn, changeset) do
    Logger.log_validation_error(changeset, %{path: conn.request_path})
    
    errors = 
      changeset.errors
      |> Enum.map(fn {field, {message, _}} -> 
        "#{field}: #{message}" 
      end)
      |> Enum.join(", ")

    response = %{
      status: "error",
      message: "Validation failed",
      errors: errors,
      timestamp: DateTime.utc_now()
    }
    
    conn
    |> put_status(:unprocessable_entity)
    |> json(response)
  end

  # CREATE - POST /api/users
  def create(conn, params) do
    try do
      Logger.log_user_action("create_user", nil, %{params: params})
      
      case Users.create_user(params) do
        {:ok, user} ->
          Logger.log_user_action("user_created", user.id, %{email: user.email})
          
          response = %{
            status: "success",
            message: "User created successfully",
            data: user,
            timestamp: DateTime.utc_now()
          }
          
          conn
          |> put_status(:created)
          |> json(response)
          
        {:error, changeset} ->
          handle_validation_error(conn, changeset)
      end
    rescue
      error -> 
        Logger.log_error(error, %{action: "create_user", params: params})
        handle_error(conn, "Internal server error")
    end
  end

  # READ - GET /api/users
  def index(conn, params) do
    try do
      # Параметры пагинации
      limit = String.to_integer(params["limit"] || "50")
      offset = String.to_integer(params["offset"] || "0")
      
      # Поиск
      users = if params["search"] do
        Users.search_users(params["search"])
      else
        Users.list_users(limit: limit, offset: offset)
      end
      
      total_count = Users.count_users()
      
      response = %{
        status: "success",
        message: "Users retrieved successfully",
        data: users,
        pagination: %{
          limit: limit,
          offset: offset,
          total: total_count,
          has_more: offset + limit < total_count
        },
        timestamp: DateTime.utc_now()
      }
      
      json(conn, response)
    rescue
      error -> 
        IO.inspect(error, label: "INDEX Users Error")
        handle_error(conn, "Internal server error")
    end
  end

  # READ - GET /api/users/:id
  def show(conn, %{"id" => id}) do
    try do
      user = Users.get_user!(id)
      
      response = %{
        status: "success",
        message: "User retrieved successfully",
        data: user,
        timestamp: DateTime.utc_now()
      }
      
      json(conn, response)
    rescue
      Ecto.NoResultsError ->
        response = %{
          status: "error",
          message: "User not found",
          timestamp: DateTime.utc_now()
        }
        
        conn
        |> put_status(:not_found)
        |> json(response)
        
      error -> 
        IO.inspect(error, label: "SHOW User Error")
        handle_error(conn, "Internal server error")
    end
  end

  # UPDATE - PUT /api/users/:id
  def update(conn, %{"id" => id} = params) do
    try do
      user = Users.get_user!(id)
      user_params = Map.delete(params, "id")
      
      case Users.update_user(user, user_params) do
        {:ok, updated_user} ->
          response = %{
            status: "success",
            message: "User updated successfully",
            data: updated_user,
            timestamp: DateTime.utc_now()
          }
          
          json(conn, response)
          
        {:error, changeset} ->
          handle_validation_error(conn, changeset)
      end
    rescue
      Ecto.NoResultsError ->
        response = %{
          status: "error",
          message: "User not found",
          timestamp: DateTime.utc_now()
        }
        
        conn
        |> put_status(:not_found)
        |> json(response)
        
      error -> 
        IO.inspect(error, label: "UPDATE User Error")
        handle_error(conn, "Internal server error")
    end
  end

  # DELETE - DELETE /api/users/:id
  def delete(conn, %{"id" => id}) do
    try do
      user = Users.get_user!(id)
      
      case Users.delete_user(user) do
        {:ok, deleted_user} ->
          response = %{
            status: "success",
            message: "User deleted successfully",
            data: deleted_user,
            timestamp: DateTime.utc_now()
          }
          
          json(conn, response)
          
        {:error, changeset} ->
          handle_validation_error(conn, changeset)
      end
    rescue
      Ecto.NoResultsError ->
        response = %{
          status: "error",
          message: "User not found",
          timestamp: DateTime.utc_now()
        }
        
        conn
        |> put_status(:not_found)
        |> json(response)
        
      error -> 
        IO.inspect(error, label: "DELETE User Error")
        handle_error(conn, "Internal server error")
    end
  end

  # SEARCH - GET /api/users/search/:query
  def search(conn, %{"query" => query}) do
    try do
      users = Users.search_users(query)
      
      response = %{
        status: "success",
        message: "Search completed",
        data: users,
        query: query,
        count: length(users),
        timestamp: DateTime.utc_now()
      }
      
      json(conn, response)
    rescue
      error -> 
        IO.inspect(error, label: "SEARCH Users Error")
        handle_error(conn, "Internal server error")
    end
  end

  # SEARCH BY QUERY - GET /api/users/search?query=...
  def search_by_query(conn, params) do
    try do
      query = params["query"] || ""
      
      if query == "" do
        response = %{
          status: "error",
          message: "Query parameter is required",
          timestamp: DateTime.utc_now()
        }
        
        conn
        |> put_status(:bad_request)
        |> json(response)
      else
        users = Users.search_users(query)
        
        response = %{
          status: "success",
          message: "Search completed",
          data: users,
          query: query,
          count: length(users),
          timestamp: DateTime.utc_now()
        }
        
        json(conn, response)
      end
    rescue
      error -> 
        IO.inspect(error, label: "SEARCH BY QUERY Users Error")
        handle_error(conn, "Internal server error")
    end
  end
end
