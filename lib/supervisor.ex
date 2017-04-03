defmodule Dungeon.Supervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_) do
    opts = [
      strategy: :one_for_one
    ]
    children = [
      supervisor(Dungeon.PlayerSupervisor, []),
      supervisor(Dungeon.MonsterSupervisor, []) 
    ]

    supervise(children, opts)
  end
end
