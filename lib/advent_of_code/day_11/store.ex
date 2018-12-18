defmodule AdventOfCode.Day11.Store do
  use GenServer

  def start_link() do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_) do
    :grid = :ets.new(:grid, [:named_table, read_concurrency: true])
    {:ok, %{}}
  end

  def write(val) do
    GenServer.call(__MODULE__, {:write, val})
  end

  def handle_call({write, val}, _, state) do
    :ets.insert(:grid, val)
    {:reply, :ok, state}
  end
end
