defmodule Hello2.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :id, autogenerate: true}
  @foreign_key_type :id

  schema "users" do
    field :name, :string
    field :email, :string
    field :age, :integer
    field :is_active, :boolean, default: true
    field :bio, :string
    field :metadata, :map, default: %{}

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :age, :is_active, :bio, :metadata])
    |> validate_required([:name, :email])
    |> validate_format(:email, ~r/^[^\s]+@[^\s]+\.[^\s]+$/, message: "must be a valid email")
    |> validate_length(:name, min: 2, max: 100)
    |> validate_length(:bio, max: 500)
    |> validate_number(:age, greater_than: 0, less_than: 150, message: "must be between 1 and 149")
    |> unique_constraint(:email, message: "email already exists")
  end

  @doc """
  Changeset for updates (allows partial updates)
  """
  def update_changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :age, :is_active, :bio, :metadata])
    |> validate_format(:email, ~r/^[^\s]+@[^\s]+\.[^\s]+$/, message: "must be a valid email")
    |> validate_length(:name, min: 2, max: 100)
    |> validate_length(:bio, max: 500)
    |> validate_number(:age, greater_than: 0, less_than: 150, message: "must be between 1 and 149")
    |> unique_constraint(:email, message: "email already exists")
  end
end
