defmodule SoftieWeb.ArticleLive do
  use Phoenix.LiveView

  def render(assigns) do
    ~L"""
    Current temperature: <%= @temperature %>
    """
  end

  def mount(params, socket) do
    case Thermostat.get_user_reading() do
      {:ok, temperature} ->
        {:ok, assign(socket, :temperature, temperature)}

      {:error, reason} ->
        {:error, reason}
    end
  end
end

defmodule Thermostat do
  def get_user_reading() do
    {:ok, 20}
  end
end
