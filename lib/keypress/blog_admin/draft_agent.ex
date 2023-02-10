defmodule Keypress.BlogAdmin.DraftAgent do
  use Agent

  def start_link(_) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def save_params(type, params) do
    Agent.update(__MODULE__, fn state ->
      Map.put(state, type, params)
    end)
  end

  def fetch_params(type) do
    Agent.get(__MODULE__, fn state ->
      Map.fetch(state, type)
    end)
  end

  def clear_params(type) do
    Agent.update(__MODULE__, fn state ->
      Map.delete(state, type)
    end)
  end
end
