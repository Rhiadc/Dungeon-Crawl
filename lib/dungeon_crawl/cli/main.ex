defmodule DungeonCrawl.CLI.Main do
    alias Mix.Shell.IO, as: Shell
    alias DungeonCrawl.Character
    import DungeonCrawl.CLI.BaseCommands
    #testar usar o alias


    def start_game() do
        welcome_message()
        Shell.prompt("Press enter to continue")
        dificulty = select_dificulty(["easy", "medium", "hard"])
        crawl(hero_choice(dificulty), DungeonCrawl.Room.all())
    end

    def select_dificulty(dificulty) do
        dificulty
        |> display_options
        |> generate_question_dificulty
        |> Shell.prompt
        |> parse_answer_dificulty
        

    end

    defp welcome_message do
        Shell.info("=== Dungeon Crawl ===")
        Shell.info("You awake in a dungeon full of monsters.")
        Shell.info("You need to survive and find the exit")
    end

    defp hero_choice(dificulty) do
        hero = DungeonCrawl.CLI.HeroChoice.start()
        %{hero | name: "You", dificulty: dificulty}
    end

    defp trigger_action({room, action}, character) do
        Shell.cmd("clear")
        room.trigger.run(character, action)
    end

    defp reroll(rooms, _char = %{dificulty: 1}) do
        IO.puts "something"
        Enum.random(rooms)
    end

    defp reroll(rooms, _char = %{dificulty: 2}) do
        selected_room = Enum.random(rooms)
        if selected_room.description == "You can see the light of day. You found the exit!" do
            Enum.random(rooms)
        else 
            selected_room
        end
    end

    defp reroll(rooms, _char = %{dificulty: 3}) do
        selected_room = Enum.random(rooms)
        if selected_room.description == "You can see the light of day. You found the exit!" do
            Enum.random(rooms)
        else 
            selected_room
        end
    end


    defp handle_action_result({_, :exit}),
        do: Shell.info("You found the exit. You won the game. Congratulations!")

    defp handle_action_result({character, _}),
        do: crawl(character, DungeonCrawl.Room.all())

    defp crawl(%{hit_points: 0}, _) do
        Shell.prompt("")
        Shell.cmd("clear")
        Shell.info("Unfortunately your wounds are too many to keep walking.")
        Shell.info("You fall onto the floor without strength to carry on.")
        Shell.info("Game over!")
        Shell.prompt("")
    end

    defp crawl(character, rooms) do
        Shell.info("You keep moving forward to the next room.")
        Shell.prompt("Press Enter to continue")
        Shell.cmd("clear")

        Shell.info(Character.current_stats(character))
        Shell.info(Character.current_dificulty(character))
        rooms
        |> reroll(character)
        |> DungeonCrawl.CLI.RoomActionsChoice.start
        |> trigger_action(character)
        |> handle_action_result
    end
end