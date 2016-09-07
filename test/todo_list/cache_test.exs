defmodule TodoList.CacheTest do
  use ExUnit.Case

  alias TodoList.Cache

  setup do
    list = %{name: "Home", items: []}
    Cache.save(list)

    {:ok, list: list}
  end

  test ".save adds an entry to the ETS table" do
    info = :ets.info(Cache)
    assert info[:size] == 1
  end

  test ".find finds a list from an ETS table by name", %{list: list} do
    assert Cache.find("Home") == list
  end

  test ".clear deletes the cache" do
    Cache.clear
    refute Cache.find("Home")
  end
end
