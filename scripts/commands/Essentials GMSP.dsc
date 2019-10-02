# | ███████████████████████████████████████████████████████████
# % ██    /gmsp - gamemode spectator command
# | ██
# % ██  [ Command ] ██
GMSP_Command:
    type: command
    name: gmsp
    debug: false
    description: Adjusts your gamemode to Spectator Mode.
    admindescription: Adjusts another player's or your own gamemode to Spectator Mode
    usage: /gmsp
    adminusage: /gmsp (player)
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
                - if <player.gamemode> == spectator:
                    - narrate "<proc[Colorize].context[You are already in Spectator Mode.|red]>"
                - else:
                    - adjust <player> gamemode:spectator
        - else:
            - define Rank 5
            - if <player.flag[Behrry.Essentials.Rank]> > <[Rank]>:
                - inject Permission_Verification Instantly
            - else:
                - if <[User].gamemode> == spectator:
                    - narrate "<[User].name.display]> <proc[Colorize].context[is already in Spectator Mode.|red]>"
                - else:
                    - define User <context.args.get[1]>
                    - inject Player_Verification
                    - adjust <[User]> gamemode:spectator