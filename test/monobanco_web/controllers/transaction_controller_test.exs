defmodule MonobancoWeb.TransactionControllerTest do
  use MonobancoWeb.ConnCase

  alias Monobanco.Customers
  alias Monobanco.Customers.Transaction

  @create_attrs %{
    amount: 120,
    category: "some category",
    description: "some description",
    is_deposit: true
  }

  @invalid_attrs %{amount: nil, category: nil, description: nil, is_deposit: nil}

  def fixture(:transaction) do
    {:ok, transaction} = Customers.create_transaction(@create_attrs)
    transaction
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "create transaction" do
    test "renders transaction when data is valid", %{conn: conn} do
      conn = post(conn, Routes.transaction_path(conn, :create), transaction: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      assert %{
               "id" => id,
               "amount" => 120,
               "category" => "some category",
               "description" => "some description",
               "is_deposit" => true
             } = json_response(conn, 201)["data"]
    end
  end

  defp create_transaction(_) do
    transaction = fixture(:transaction)
    %{transaction: transaction}
  end
end
