defmodule DungeonCrawl.CLI.RoomActionsChoice do
    alias Mix.Shell.IO, as: Shell
    import DungeonCrawl.CLI.BaseCommands

    def start(room) do
        #room_actions = room.actions
        #find_action_by_index = &(Enum.at(room_actions, &1))

        Shell.info(room.description)

        #display_options ja invoca a lista de nomes na propria função,
        #por meio do protocolo
        chosen_action = ask_for_option(room.actions)
        {room, chosen_action}

    end

    
    
end