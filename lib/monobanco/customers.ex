defmodule Monobanco.Customers do
  @moduledoc """
  The Customers context.
  """

  import Ecto.Query, warn: false
  alias Monobanco.Repo

  alias Monobanco.Customers.Transaction

  @topic inspect(__MODULE__)

  def subscribe do
    Phoenix.PubSub.subscribe(Monobanco.PubSub, @topic)
  end

  def subscribe(transaction_id) do
    Phoenix.PubSub.subscribe(Monobanco.PubSub, @topic <> "#{transaction_id}")
  end

  def list_transactions do
    Repo.all(from t in Transaction, order_by: [desc: t.id])
  end

  def sum_deposit do
    sum = Repo.one(from t in Transaction, where: t.is_deposit == true, select: sum(t.amount))
    case sum && is_integer(sum.amount) do
      true -> sum.amount
      false -> 0
      nil -> 0
    end
  end

  def sum_withdraw do
    sum = Repo.one(from t in Transaction, where: t.is_deposit == false, select: sum(t.amount))
    case sum && is_integer(sum.amount) do
      true -> sum.amount
      false -> 0
      nil -> 0
    end
  end

  def available_balance_transaction do
    m = Money.new(sum_deposit()-sum_withdraw())

    m
  end

  def last_withdraw do
    Repo.one(from t in Transaction, where: t.is_deposit == false, select: t.amount, limit: 1, order_by: [desc: t.id])
  end

  def last_deposit do
    Repo.one(from t in Transaction, where: t.is_deposit == true, select: t.amount, limit: 1, order_by: [desc: t.id])
  end

  @doc """
  Gets a single transaction.

  Raises `Ecto.NoResultsError` if the Transaction does not exist.

  ## Examples

      iex> get_transaction!(123)
      %Transaction{}

      iex> get_transaction!(456)
      ** (Ecto.NoResultsError)

  """
  def get_transaction!(id), do: Repo.get!(Transaction, id)

  @doc """
  Creates a transaction.

  ## Examples

      iex> create_transaction(%{field: value})
      {:ok, %Transaction{}}

      iex> create_transaction(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_transaction(attrs \\ %{}) do
    %Transaction{}
    |> Transaction.changeset(attrs)
    |> Repo.insert()
    |> notify_subscribers([:transaction, :created])
  end

  @doc """
  Updates a transaction.

  ## Examples

      iex> update_transaction(transaction, %{field: new_value})
      {:ok, %Transaction{}}

      iex> update_transaction(transaction, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_transaction(%Transaction{} = transaction, attrs) do
    transaction
    |> Transaction.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a transaction.

  ## Examples

      iex> delete_transaction(transaction)
      {:ok, %Transaction{}}

      iex> delete_transaction(transaction)
      {:error, %Ecto.Changeset{}}

  """
  def delete_transaction(%Transaction{} = transaction) do
    Repo.delete(transaction)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking transaction changes.

  ## Examples

      iex> change_transaction(transaction)
      %Ecto.Changeset{data: %Transaction{}}

  """
  def change_transaction(%Transaction{} = transaction, attrs \\ %{}) do
    Transaction.changeset(transaction, attrs)
  end

  defp notify_subscribers({:ok, result}, event) do
    Phoenix.PubSub.broadcast(Monobanco.PubSub, @topic, {__MODULE__, event, result})
    Phoenix.PubSub.broadcast(Monobanco.PubSub, @topic <> "#{result.id}", {__MODULE__, event, result})
    {:ok, result}
  end

  defp notify_subscribers({:error, reason}, _event), do: {:error, reason}
end
