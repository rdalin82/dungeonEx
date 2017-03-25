defmodule Player do
  use GenServer

  defmodule PlayerStats do
    defstruct hp: 100, xp: 0, name: ""
  end

  def start_link(name \\ __MODULE__) do
    GenServer.start_link(__MODULE__, %PlayerStats{name: name}, name: name)
  end

  def hp(name \\__MODULE__) do
    GenServer.call(name, :hp)
  end

  def attacked(name \\__MODULE__, damage \\ 1) do
    GenServer.cast(__MODULE__, {:attacked, damage})
  end

  def attack(name \\__MODULE__, module, damage \\1) do
    GenServer.cast(module, {:attacked, damage, name})
  end

  def receive_xp(name \\__MODULE__, xp) do
    GenServer.cast(__MODULE__, {:receive_xp, xp} )
  end

  def xp(name \\__MODULE__) do
    GenServer.call(name, :xp)
  end

  #callbacks
  def init(player) do
    {:ok, player}
  end

  def handle_call(:hp, _from, player) do
    hp = player.hp
    {:reply, hp, player}
  end

  def handle_call(:xp, _from, player) do
    xp = player.xp
    {:reply, xp, player}
  end 

  def handle_cast({:attacked, damage}, player) do
    updated_player = Map.put(player, :hp, player.hp - damage)
    {:noreply, updated_player}
  end

  def handle_cast({:receive_xp, xp}, player) do
    updated_player = Map.put(player, :xp, player.xp + xp)
    {:noreply, updated_player}
  end

end
