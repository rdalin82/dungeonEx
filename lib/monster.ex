defmodule Monster do
  use GenServer

  #api
  def start_link(hp \\ 100) do
    GenServer.start_link(__MODULE__, hp, name: __MODULE__)
  end

  def hp do
    GenServer.call(__MODULE__, :hp)
  end

  def attacked(damage \\ 1) do
    GenServer.cast(__MODULE__, {:attacked, damage})
  end

  @doc """
    for attacking a player pass the name as player
    ex:
    > Player.start_link
    > Monster.start_link
    > Monster.attack(Player, 2)  # {:ok}
    > Player.hp                  # {:reply, 98}  hp minus damage

    """
  def attack(module, damage \\1) do
    GenServer.cast(module, {:attacked, damage})
  end


  #callbacks to server
  def init(hp) do
    {:ok, hp}
  end

  def handle_call(:hp, _from, hp) do
    {:reply, hp, hp}
  end

  def handle_cast({:attacked, damage, name}, hp) do
    new_hp = hp - damage
    if (new_hp > 0) do
      {:noreply, new_hp}
    else
      GenServer.cast(name, {:receive_xp, 10})
      {:noreply, new_hp} #kill?
    end
  end

end
