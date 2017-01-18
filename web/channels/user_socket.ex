defmodule CanvasAPI.UserSocket do
  use Phoenix.Socket

  alias CanvasAPI.TokenService

  ## Channels
  channel "team:*", CanvasAPI.TeamChannel

  ## Transports
  transport :websocket, Phoenix.Transports.WebSocket,
    timeout: 30_000 # Shorter than Herkou timeout of 60_000

  # Socket params are passed from the client and can
  # be used to verify and authenticate a user. After
  # verification, you can put default assigns into
  # the socket that will be set for all channels, ie
  #
  #     {:ok, assign(socket, :user_id, verified_user_id)}
  #
  # To deny connection, return `:error`.
  #
  # See `Phoenix.Token` documentation for examples in
  # performing token verification on connect.
  def connect(params, socket) do
    (params["token"] || "")
    |> TokenService.verify
    |> case do
      {:ok, account} ->
        {:ok, assign(socket, :current_account, account)}
      _error ->
        :error
    end
  end

  # Socket id's are topics that allow you to identify all sockets for a given
  # user:
  #
  #     def id(socket), do: "users_socket:#{socket.assigns.user_id}"
  #
  # Would allow you to broadcast a "disconnect" event and terminate
  # all active sockets and channels for a given user:
  #
  #     CanvasAPI.Endpoint.broadcast(
  #       "users_socket:#{user.id}", "disconnect", %{})
  #
  # Returning `nil` makes this socket anonymous.
  def id(_socket), do: nil
end
