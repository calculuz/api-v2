defmodule CanvasAPI.Account do
  @moduledoc """
  A user account, representing one or more Slack users.
  """

  use CanvasAPI.Web, :model

  @type t :: %__MODULE__{}

  schema "accounts" do
    many_to_many :teams, CanvasAPI.Team, join_through: "users"
    has_many :users, CanvasAPI.User
    has_many :canvases, through: [:users, :canvases]
    has_many :comments, through: [:canvases, :comments]
    has_many :oauth_tokens, CanvasAPI.OAuthToken
    has_many :personal_access_tokens, CanvasAPI.PersonalAccessToken
    has_many :ui_dismissals, CanvasAPI.UIDismissal
    has_many :canvas_watches, through: [:users, :canvas_watches]
    has_many :thread_subscriptions, through: [:users, :thread_subscriptions]

    timestamps
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [])
  end
end
