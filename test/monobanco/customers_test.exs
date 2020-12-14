defmodule Monobanco.CustomersTest do
  use Monobanco.DataCase

  alias Monobanco.Customers

  describe "transactions" do
    alias Monobanco.Customers.Transaction

    @valid_attrs %{amount: 120, category: "some category", description: "some description", is_deposit: true}
    @update_attrs %{amount: 456, category: "some updated category", description: "some updated description", is_deposit: false}
    @invalid_attrs %{amount: nil, category: nil, description: nil, is_deposit: nil}

    def transaction_fixture(attrs \\ %{}) do
      {:ok, transaction} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Customers.create_transaction()

      transaction
    end

    test "list_transactions/0 returns all transactions" do
      transaction = transaction_fixture()
      assert Customers.list_transactions() == [transaction]
    end

    test "get_transaction!/1 returns the transaction with given id" do
      transaction = transaction_fixture()
      assert Customers.get_transaction!(transaction.id) == transaction
    end

    test "create_transaction/1 with valid data creates a transaction" do
      assert {:ok, %Transaction{} = transaction} = Customers.create_transaction(@valid_attrs)
      assert transaction.amount.amount == 120
      assert transaction.category == "some category"
      assert transaction.description == "some description"
      assert transaction.is_deposit == true
    end

    test "create_transaction/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Customers.create_transaction(@invalid_attrs)
    end

    test "update_transaction/2 with valid data updates the transaction" do
      transaction = transaction_fixture()
      assert {:ok, %Transaction{} = transaction} = Customers.update_transaction(transaction, @update_attrs)
      assert transaction.amount.amount == 456
      assert transaction.category == "some updated category"
      assert transaction.description == "some updated description"
      assert transaction.is_deposit == false
    end

    test "update_transaction/2 with invalid data returns error changeset" do
      transaction = transaction_fixture()
      assert {:error, %Ecto.Changeset{}} = Customers.update_transaction(transaction, @invalid_attrs)
      assert transaction == Customers.get_transaction!(transaction.id)
    end

    test "delete_transaction/1 deletes the transaction" do
      transaction = transaction_fixture()
      assert {:ok, %Transaction{}} = Customers.delete_transaction(transaction)
      assert_raise Ecto.NoResultsError, fn -> Customers.get_transaction!(transaction.id) end
    end

    test "change_transaction/1 returns a transaction changeset" do
      transaction = transaction_fixture()
      assert %Ecto.Changeset{} = Customers.change_transaction(transaction)
    end
  end
end
