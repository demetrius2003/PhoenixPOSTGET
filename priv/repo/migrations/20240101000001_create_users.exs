defmodule Hello2.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string, null: false
      add :email, :string, null: false
      add :age, :integer
      add :is_active, :boolean, default: true
      add :bio, :text
      add :metadata, :map, default: %{}

      timestamps()
    end

    create unique_index(:users, [:email])
    create index(:users, [:name])
    create index(:users, [:is_active])
  end
end
