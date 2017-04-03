defmodule Dungeon.MonsterSupervisor do
  use Supervisor

  @name MonsterSupervisor

  def start_link do
    Supervisor.start_link(__MODULE__, [], name: @name)
  end

  def init([]) do
    children = [
      worker(Dungeon.Monster, [:monster1], [id: self()]),
      worker(Dungeon.Monster, [:monster2], [id: :monster2])
    ]
    opts = [
      strategy: :one_for_one
    ]
    supervise(children, opts)
  end
end
