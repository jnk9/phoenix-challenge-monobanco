defmodule MonobancoWeb.PageLive do
  use MonobancoWeb, :live_view
  alias Monobanco.Customers 

  @impl true
  def mount(_params, _session, socket) do
    Customers.subscribe()
    Phoenix.PubSub.subscribe(Monobanco.PubSub, "transactions")
    transactions = Customers.list_transactions()
    {
      :ok,
      assign(
        socket, 
        available_balance: Customers.available_balance_transaction(),
        last_withdraw: Customers.last_withdraw(),
        last_deposit: Customers.last_deposit(),
        lastest_transactions: transactions
      )
    }
  end

  def hola do
    "hola"
  end
end
