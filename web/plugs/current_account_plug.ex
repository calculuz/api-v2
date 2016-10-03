defmodule CanvasAPI.CurrentAccountPlug do
  @moduledoc """
  A plug for ensuring that the current account is present on the connection.
  """

  alias CanvasAPI.{Account, ErrorView, Repo}
  import Phoenix.Controller
  import Plug.Conn

  @behaviour Plug

  def init(opts), do: opts

  def call(conn = %{private: %{current_account: %Account{}}}, _), do: conn

  def call(conn, opts) do
    with account_id when not is_nil(account_id) <-
           get_session(conn, :account_id),
         account = %Account{} <- Repo.get(Account, account_id) do
      put_private(conn, :current_account, account)
    else
      _ ->
        if opts[:permit_none] do
          conn
        else
          conn
          |> halt
          |> put_status(:unauthorized)
          |> render(ErrorView, "401.json")
        end
    end
  end
end
