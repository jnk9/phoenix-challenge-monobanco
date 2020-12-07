defmodule MonobancoWeb.TransactionView do
  use MonobancoWeb, :view
  alias MonobancoWeb.TransactionView

  def render("index.json", %{transactions: transactions}) do
    %{data: render_many(transactions, TransactionView, "transaction.json")}
  end

  def render("show.json", %{transaction: transaction}) do
    %{data: render_one(transaction, TransactionView, "transaction.json")}
  end

  def render("transaction.json", %{transaction: transaction}) do
    %{id: transaction.id,
      category: transaction.category,
      description: transaction.description,
      amount: transaction.amount,
      is_deposit: transaction.is_deposit}
  end
end
