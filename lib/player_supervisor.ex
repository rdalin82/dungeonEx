defmodule Dungeon.PlayerSupervisor do
  use Supervisor

  @name PlayerSupervisor

  def start_link do
    Supervisor.start_link(__MODULE__, [], name: @name)
  end

  def which_children do
    Supervisor.which_children(@name)
  end

  def init([]) do
    children = [
      worker(Dungeon.Player, [:rob], [id: :rob]),
      worker(Dungeon.Player, [:mark], [id: :mark]),
    ]
    opts = [
      strategy: :one_for_one
    ]
    supervise(children, opts)
  end
end
