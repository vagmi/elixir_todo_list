defmodule TodoList.Cache do
  use GenServer
  import String, only: [to_atom: 1]

  def save(list) do
    :ets.insert(__MODULE__, {to_atom(list.name), list})
  end

  def find(name) do
    case :ets.lookup(__MODULE__, to_atom(name)) do
      [{_id, value}] -> value
      [] -> nil
    end
  end

  def clear do
    :ets.delete_all_objects(__MODULE__)
  end

  # GenServer API

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_) do
    table = :ets.new(__MODULE__, [:named_table, :public])
    {:ok, table}
  end

end
