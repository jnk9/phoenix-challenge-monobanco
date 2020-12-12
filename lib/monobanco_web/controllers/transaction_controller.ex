defmodule MonobancoWeb.TransactionController do
  use MonobancoWeb, :controller

  alias Monobanco.Customers
  alias Monobanco.Customers.Transaction

  action_fallback MonobancoWeb.FallbackController

  def create(conn, %{"transaction" => transaction_params}) do
    with {:ok, %Transaction{} = transaction} <- Customers.create_transaction(transaction_params) do
      conn
      |> put_status(:created)
      |> render("show.json", transaction: transaction)
    end
  end

end
