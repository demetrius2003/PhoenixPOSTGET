defmodule Hello2Web.UserControllerTest do
  use Hello2Web.ConnCase
  alias Hello2.Users

  @create_attrs %{
    name: "John Doe",
    email: "john@example.com",
    age: 30,
    bio: "Software developer",
    is_active: true
  }

  @update_attrs %{
    name: "John Smith",
    email: "johnsmith@example.com",
    age: 31,
    bio: "Senior software developer"
  }

  @invalid_attrs %{
    name: "",
    email: "invalid-email",
    age: -1
  }

  def fixture(:user) do
    {:ok, user} = Users.create_user(@create_attrs)
    user
  end

  describe "index" do
    test "lists all users", %{conn: conn} do
      conn = get(conn, "/api/users")
      assert json_response(conn, 200)["status"] == "success"
    end

    test "lists users with pagination", %{conn: conn} do
      conn = get(conn, "/api/users?limit=10&offset=0")
      response = json_response(conn, 200)
      assert response["status"] == "success"
      assert Map.has_key?(response, "pagination")
    end
  end

  describe "create user" do
    test "renders user when data is valid", %{conn: conn} do
      conn = post(conn, "/api/users", user: @create_attrs)
      response = json_response(conn, 201)
      assert response["status"] == "success"
      assert response["data"]["name"] == @create_attrs.name
      assert response["data"]["email"] == @create_attrs.email
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, "/api/users", user: @invalid_attrs)
      response = json_response(conn, 422)
      assert response["status"] == "error"
      assert response["message"] == "Validation failed"
    end
  end

  describe "show user" do
    setup [:create_user]

    test "renders user when id is valid", %{conn: conn, user: user} do
      conn = get(conn, "/api/users/#{user.id}")
      response = json_response(conn, 200)
      assert response["status"] == "success"
      assert response["data"]["id"] == user.id
    end

    test "renders error when id is invalid", %{conn: conn} do
      conn = get(conn, "/api/users/999999")
      response = json_response(conn, 404)
      assert response["status"] == "error"
      assert response["message"] == "User not found"
    end
  end

  describe "update user" do
    setup [:create_user]

    test "renders user when data is valid", %{conn: conn, user: user} do
      conn = put(conn, "/api/users/#{user.id}", user: @update_attrs)
      response = json_response(conn, 200)
      assert response["status"] == "success"
      assert response["data"]["name"] == @update_attrs.name
    end

    test "renders errors when data is invalid", %{conn: conn, user: user} do
      conn = put(conn, "/api/users/#{user.id}", user: @invalid_attrs)
      response = json_response(conn, 422)
      assert response["status"] == "error"
    end

    test "renders error when id is invalid", %{conn: conn} do
      conn = put(conn, "/api/users/999999", user: @update_attrs)
      response = json_response(conn, 404)
      assert response["status"] == "error"
    end
  end

  describe "delete user" do
    setup [:create_user]

    test "deletes chosen user", %{conn: conn, user: user} do
      conn = delete(conn, "/api/users/#{user.id}")
      response = json_response(conn, 200)
      assert response["status"] == "success"

      conn = get(conn, "/api/users/#{user.id}")
      response = json_response(conn, 404)
      assert response["status"] == "error"
    end

    test "renders error when id is invalid", %{conn: conn} do
      conn = delete(conn, "/api/users/999999")
      response = json_response(conn, 404)
      assert response["status"] == "error"
    end
  end

  describe "search users" do
    setup [:create_user]

    test "searches users by name", %{conn: conn, user: user} do
      conn = get(conn, "/api/users/search/John")
      response = json_response(conn, 200)
      assert response["status"] == "success"
      assert length(response["data"]) >= 1
    end

    test "searches users by email", %{conn: conn, user: user} do
      conn = get(conn, "/api/users/search/example.com")
      response = json_response(conn, 200)
      assert response["status"] == "success"
      assert length(response["data"]) >= 1
    end

    test "returns empty list when no matches", %{conn: conn} do
      conn = get(conn, "/api/users/search/nonexistent")
      response = json_response(conn, 200)
      assert response["status"] == "success"
      assert response["data"] == []
    end
  end

  defp create_user(_) do
    user = fixture(:user)
    %{user: user}
  end
end
