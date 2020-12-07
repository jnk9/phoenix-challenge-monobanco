defmodule Monobanco.Customers.Transaction do
  use Ecto.Schema
  import Ecto.Changeset

  schema "transactions" do
    field :amount, :float
    field :category, :string
    field :description, :string
    field :is_deposit, :boolean, default: true

    timestamps()
  end

  @doc false
  def changeset(transaction, attrs) do
    transaction
    |> cast(attrs, [:category, :description, :amount, :is_deposit])
    |> validate_required([:category, :description, :amount, :is_deposit])
  end
end
