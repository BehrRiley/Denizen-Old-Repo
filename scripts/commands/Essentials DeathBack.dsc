# | ███████████████████████████████████████████████████████████
# % ██    DeathBack / DBack - similar to /Back, but returns you
# % ██    to your death location alternatively.
# | ██
# % ██  [ Command ] ██
# $ ██  [ TO-DO   ] ██ | Add a click button to opt teleporting back to a dangerous location
deathback_Command:
    type: command
    name: deathback
    debug: false
    description: Returns you back your death location.
    use: "<proc[colorize].context[/deathback|yellow]>"
    aliases:
        - dback
    script:
        - if <context.args.get[1]||null> != null:
            - inject Command_Syntax Instantly
        - if <player.has_flag[behrry.essentials.teleport.deathback]>:
            - narrate "<proc[Colorize].context[Returning to death location.|green]>"
            - flag <player> behrry.essentials.teleport.back:<player.location>
            - teleport <player> <player.flag[behrry.essentials.teleport.deathback].as_location>
        - else:
            - narrate "<proc[Colorize].context[No death location to return to.|red]>"
