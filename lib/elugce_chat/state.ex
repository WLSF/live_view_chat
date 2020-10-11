defmodule ElugceChat.State do
  use GenServer

  def init(state), do: {:ok, state}
  def start_link(state), do: GenServer.start_link(__MODULE__, state, name: __MODULE__)

  def handle_cast({:push, value}, state), do: {:noreply, state ++ [value]}
  def handle_call(:pop, _params, [value | state]), do: {:reply, value, state}
  def handle_call(:pop, _params, []), do: {:reply, nil, []}
  def handle_call(:list, _params, state) do
    {:reply, state, state}
  end

  def list(), do: GenServer.call(__MODULE__, :list)
  def push(value), do: GenServer.cast(__MODULE__, {:push, value})
  def pop(), do: GenServer.call(__MODULE__, :pop)

end
