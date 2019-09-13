# | ███████████████████████████████████████████████████████████
# % ██    /back - returns you to where you teleported from
# | ██
# % ██  [ Command ] ██
# $ ██  [ TO-DO   ] ██ | furnish script |
back_Command:
    type: command
    name: back
    debug: false
    description: Returns you back to your last location.
    use: "<proc[colorize].context[/back|yellow]>"
    script:
        - if <context.args.get[1]||null> != null:
            - inject Command_Syntax Instantly
        - define Blacklist <list[Blaze|Cave_Spider|Creeper|Drowned|Elder_Guardian|Ender_Dragon|Enderman|Endermite|Evoker|Ghast|Guardian|Husk|Illusioner|Magma_Cube|Phantom|Pillager|Ravager|Shulker|Silverfish|Skeleton|Slime|Cave_SpiderStray|Vex|Vindicator|Witch|Wither|Zombie]>
        - if <player.location.find.entities[<[Blacklist]>].within[20].size> != 0:
            - narrate "<proc[Colorize].context[You cannot return with enemies near-by.|red]>"
        - else:
            - if <player.has_flag[behrry.essentials.teleport.back]>:
                - narrate "<proc[Colorize].context[Returning to last location.|green]>"
                - flag <player> behrry.essentials.teleport.back:<player.location>
                - teleport <player.flag[behrry.essentials.teleport.back]>
            - else:
                - narrate "<proc[Colorize].context[No back location to return to.|red]>"



