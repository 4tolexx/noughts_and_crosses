defmodule TictactoeWeb.Plugs.Session do

  import Plug.Conn

  alias TictactoeWeb.PlayerETS

  require Logger

  def init(options) do
    options
  end

  def call(conn, _opts) do
    case get_session(conn, :session_uuid) do
      nil ->
        put_session(conn, :session_uuid, Ecto.UUID.generate())

      session_uuid ->
        player_name = PlayerETS.find_player(session_uuid)

        put_player_in_session(conn, player_name)
    end
  end

  defp put_player_in_session(conn, nil), do: conn

  defp put_player_in_session(conn, player_name) do
    conn
    |> assign(:player_name, player_name)
    |> put_session("player_name", player_name)
  end
end
