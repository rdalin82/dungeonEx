defmodule Dungeon do
  use Application

  def start(_, _) do
    Dungeon.Supervisor.start_link
  end
end
