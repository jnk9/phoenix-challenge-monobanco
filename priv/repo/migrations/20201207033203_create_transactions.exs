defmodule Monobanco.Repo.Migrations.CreateTransactions do
  use Ecto.Migration

  def change do
    create table(:transactions) do
      add :category, :string
      add :description, :string
      add :amount, :float
      add :is_deposit, :boolean, default: false, null: false

      timestamps()
    end

  end
end
