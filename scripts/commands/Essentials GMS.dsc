# | ███████████████████████████████████████████████████████████
# % ██    /gms - gamemode survival command
# | ██
# % ██  [ Command ] ██
GMS_Command:
    type: command
    name: gms
    debug: false
    description: Adjusts your gamemode to Survival Mode.
    admindescription: Adjusts another player's or your own gamemode to Survival Mode
    use: "<proc[colorize].context[/gms|yellow]>"
    adminuse: "<proc[colorize].context[/gms (player)|yellow]>"
    tab complete:
        - if <player.flag[Behrry.Essentials.Rank]> < 3:
            - if <context.args.size||0> == 0:
            - determine <server.list_online_players.parse[name]>
            - else if <context.args.size> == 1 && !<context.raw_args.ends_with[<&sp>]>:
            - determine <server.list_online_players.parse[name].filter[starts_with[<context.args.get[1]>]]>
    script:
        - if <context.args.get[2]||null> != null:
            - inject Command_Syntax Instantly
        - if <context.args.get[1]||null> == null:
            - define Rank 4
            - if <player.flag[Behrry.Essentials.Rank]> > <[Rank]>:
                - inject Permission_Verification Instantly
            - else:
                - if <player.gamemode> == survival:
                    - narrate "<proc[Colorize].context[You are already in Survival Mode.|red]>"
                - else:
                    - adjust <player> gamemode:survival
        - else:
            - define Rank 5
            - if <player.flag[Behrry.Essentials.Rank]> > <[Rank]>:
                - inject Permission_Verification Instantly
            - else:
                - if <[User].gamemode> == survival:
                    - narrate "<[User].name.display]> <proc[Colorize].context[is already in Survival Mode.|red]>"
                - else:
                    - define User <context.args.get[1]>
                    - inject Player_Verification
                    - adjust <[User]> gamemode:survival