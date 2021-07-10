defmodule DungeonCrawl.CLI.HeroChoice do
    alias Mix.Shell.IO, as: Shell
    import DungeonCrawl.CLI.BaseCommands

    def start do
        Shell.cmd("clear")
        Shell.info("Start by choosing your hero:")

        heroes = DungeonCrawl.Heroes.all()
        #find_hero_by_index = &Enum.at(heroes, &1)
        heroes
        #Enum.map(&(&1.name)) retorna uma lista com o nome dos herois
        #display_options já invoca nome diretamente na função, com o uso de protocolos
        #|> Enum.map(&(&1.name))
        |> ask_for_option
        |> confirm_hero
        end

    defp confirm_hero(chosen_hero) do
        Shell.cmd("clear")
        Shell.info(chosen_hero.description)
        if Shell.yes?("Confirm?"), do: chosen_hero, else: start()
    end
end