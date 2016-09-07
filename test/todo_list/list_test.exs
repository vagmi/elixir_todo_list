defmodule TodoList.ListTest do
  use ExUnit.Case

  alias TodoList.List

  setup do
    {:ok, list} = List.start_link("Home")
    {:ok, list: list}
  end

  test ".items should returns the todos on the list", %{list: list} do
    assert List.items(list) == []
  end

  test ".add should be able to add an item to a list", %{list: list} do
    item = TodoList.Item.new("some item")
    List.add(list, item)
    assert List.items(list) == [item]
  end

  test ".update can mark an item complete in list", %{list: list} do
    item = TodoList.Item.new("to be completed")
    List.add(list, item)
    new_item = %{item | description: "completed", done: true}

    List.update(list, new_item)
    assert new_item in List.items(list)
    assert !(item in List.items(list))
  end
end
