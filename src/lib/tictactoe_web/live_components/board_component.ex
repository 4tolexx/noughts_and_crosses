defmodule TictactoeWeb.BoardComponent do
  use TictactoeWeb, :live_component

  def render(assigns) do
    ~L"""
    <div class="grid grid-cols-3 gap-2 p-5">
      <%= for positions <- split_in_rows_with_index(@game, 3) do %>
        <%= for {symbol, index} <- positions do %>
          <%= if player_turn?(@game, @player) do %>
            <button class="<%= row_style(symbol) %>" phx-click="put_symbol" phx-value-index="<%= index %>">
              <span class="mb-5"><%= symbol %></span>
            </button>
          <% else %>
            <button class="<%= row_style(symbol) %>">
              <span class="mb-5"><%= symbol %></span>
            </button>
          <% end %>
        <% end %>
      <% end %>
    </div>
    """
  end


  # Returns a list
  defp split_in_rows_with_index(%{board: board}, rows_number) do
    board.positions
    |> Enum.with_index()
    |> Enum.chunk_every(rows_number)
  end


  defp player_turn?(%{next: next}, %{symbol: symbol}), do: next == symbol

  defp row_style(symbol) do
    default =
      "hover:bg-gray-300 h-24 rounded-md flex items-center justify-center text-white text-7xl"

    additional =
      case symbol do
        nil ->
          " bg-gray-100"

        :x ->
          " bg-blue-300"

        :o ->
          " bg-yellow-300"
      end

    default <> additional
  end
end
