defmodule TransactionComponent do
  use Phoenix.LiveComponent


  def class_deposit(transaction) do
    if transaction.is_deposit do
      "has-text-success"
    else
      "has-text-danger"
    end
  end

  def format_date(transaction) do
    date = "#{transaction. inserted_at.year}/#{transaction. inserted_at.month}/#{transaction. inserted_at.day}"
    time = "#{transaction. inserted_at.hour}:#{transaction. inserted_at.minute}"

    date <> " " <> time
  end
end