defmodule CanvasAPI.AccountView do
  use CanvasAPI.Web, :view

  def render("show.json", %{account: account}) do
    %{data: render_one(account, CanvasAPI.AccountView, "account.json")}
  end

  def render("account.json", %{account: account}) do
    %{
      id: account.id,
      attributes: %{
        email: account.email,
        iamge_url: account.image_url,
        slack_id: account.slack_id,
        inserted_at: account.inserted_at,
        updated_at: account.updated_at
      },
      type: "account"
    }
  end
end