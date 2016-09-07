defmodule TodoList.ServerTest do
  use ExUnit.Case

  alias TodoList.Server

  setup do
    on_exit fn ->
      Enum.each Server.lists, &(Server.delete_list(&1))
    end
  end
  test ".add_list adds a new supervised process" do
    Server.add_list("List 1")
    Server.add_list("List 2")

    children = Supervisor.count_children(Server)
    assert children.active == 2
  end

  test ".find_list will get a list by name" do
    Server.add_list("find_by_name")
    list = Server.find_list("find_by_name")
    assert is_pid(list)
  end

  test ".delete list will delete a list" do
    Server.add_list("to-be-deleted")
    list = Server.find_list("to-be-deleted")

    Server.delete_list(list)
    assert !(list in Server.lists)
  end
end
