defmodule TodoList.Item do
  defstruct id: nil, description: nil, done: false

  def new(description) do
    %__MODULE__{id: :rand.uniform(1_000_000_000), description: description}
  end
end
