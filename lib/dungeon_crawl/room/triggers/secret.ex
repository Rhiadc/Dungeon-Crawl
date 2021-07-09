defmodule DungeonCrawl.Room.Triggers.Secret do
    @behaviour DungeonCrawl.Room.Trigger

    alias Mix.Shell.IO, as: Shell

    def run(character, %DungeonCrawl.Room.Action{id: :forward}) do
        Shell.info("What secrets does this room hide?")
        num = Enum.random(1..2)
        new_character = select(num, character)
        {new_character, :forward}
    end

    defp select(1, character) do
        Shell.info("You found a healing stone. Your HP bar is filled")
        %{character | hit_points: character.max_hit_points}
    end

    defp select(2, character) do 
        Shell.info("It's a trap. You lost 5 HP")
        %{character | hit_points: character.hit_points - 5}
    end
end