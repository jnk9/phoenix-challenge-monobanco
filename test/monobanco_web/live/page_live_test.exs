defmodule MonobancoWeb.PageLiveTest do
  use MonobancoWeb.ConnCase

  import Phoenix.LiveViewTest

  test "disconnected and connected render", %{conn: conn} do
    {:ok, page_live, disconnected_html} = live(conn, "/")
    assert disconnected_html =~ "Total Balance"
    assert render(page_live) =~ "Total Balance"
  end
end
