defmodule TodoList.List do
  use GenServer

  def items(list) do
    GenServer.call(list, :items)
  end

  def add(list, item) do
    GenServer.cast(list, {:add, item})
  end

  def name(list) do
    GenServer.call(list, :name)
  end

  def update(list, item) do
    GenServer.cast(list, {:update, item})
  end
  # GenServer stuff

  def start_link(name) do
    GenServer.start_link(__MODULE__, name)
  end

  def init(name) do
    state = %{name: name, items: []}
    {:ok, state}
  end

  def handle_call(:items, _from, %{items: items} = state) do
    {:reply, items, state}
  end

  def handle_call(:name, _from, %{name: name} = state) do
    {:reply, name, state}
  end

  def handle_cast({:add, item}, %{items: items} = state) do
    {:noreply, %{state | items: [item | items]}}
  end

  def handle_cast({:update, item}, %{items: items} = state) do
    matching_index = Enum.find_index(items, &(&1.id == item.id))
    new_items = List.replace_at(items, matching_index, item)
    {:noreply, %{state | items: new_items}}
  end
end
