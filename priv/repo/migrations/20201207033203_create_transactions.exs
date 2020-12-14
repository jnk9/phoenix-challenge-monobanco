defmodule Monobanco.Repo.Migrations.CreateTransactions do
  use Ecto.Migration

  def change do
    create table(:transactions) do
      add :category, :string
      add :description, :string
      add :amount, :integer
      add :is_deposit, :boolean, default: true, null: false

      timestamps()
    end

  end
end
