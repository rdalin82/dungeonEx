defmodule Dungeon.Monster do
  use GenServer

  #api
  def start_link(name\\__MODULE__, hp \\ 100) do
    GenServer.start_link(__MODULE__, hp, name: name)
  end

  def hp(name \\__MODULE__) do
    GenServer.call(name, :hp)
  end

  def attacked(name\\__MODULE__, damage \\ 1) do
    GenServer.cast(name, {:attacked, damage})
  end

  def alive?(name\\__MODULE__) do
    GenServer.call(name, :alive?)
  end


  @doc """
    for attacking a player pass the name as player
    ex:
    > Player.start_link
    > Monster.start_link
    > Monster.attack(Player, 2)  # {:ok}
    > Player.hp                  # {:reply, 98}  hp minus damage

    """
  def attack(name\\__MODULE__, module, damage \\1) do
    GenServer.cast(module, {:attacked, damage, name})
  end


  #callbacks to server
  def init(hp, monster) do
    {:ok, hp, monster}
  end

  def handle_call(:hp, _from, hp) do
    {:reply, hp, hp}
  end

  def handle_call(:alive?, _from, hp) do
    {:reply, hp > 0, hp}
  end


  def handle_cast({:attacked, damage, name}, hp) do
    new_hp = hp - damage
    if (new_hp > 0) do
      {:noreply, new_hp}
    else
      IO.puts ("Monster is dead, #{name} received 10 xp")
      GenServer.cast(name, {:receive_xp, 10})
      Process.exit(self(), :kill)
      {:noreply, new_hp}
    end
  end

end
