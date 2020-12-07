defmodule MonobancoWeb.PageLive do
  use MonobancoWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {
      :ok,
      assign(
        socket, 
        available_balance: 1_000_000,
        last_withdraw: 3_000,
        last_deposit: 50_000,
        lastest_transactions: {}
      )
    }
  end
end
