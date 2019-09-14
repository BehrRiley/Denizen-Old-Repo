# | ███████████████████████████████████████████████████████████
# % ██    /gmc - gamemode creative command
# | ██
# % ██    If a player is not high enough rank,
# % ██    A request is sent to someone who is high enough to
# % ██    adjust their gamemode.
# | ██
# % ██  [ Command ] ██
GMC_Command:
    type: command
    name: gmc
    debug: false
    description: Adjusts your gamemode to Creative Mode.
    admindescription: Adjusts another player's or your own gamemode to Creative Mode
    use: "<proc[colorize].context[/gmc|yellow]>"
    adminuse: "<proc[colorize].context[/gmc (player)|yellow]>"
    tab complete:
        - if <player.flag[Behrry.Essentials.Rank]> < 3:
            - if <context.args.size||0> == 0:
            - determine <server.list_online_players.parse[name]>
            - else if <context.args.size> == 1 && !<context.raw_args.ends_with[<&sp>]>:
            - determine <server.list_online_players.parse[name].filter[starts_with[<context.args.get[1]>]]>
    Request:
        - define DisplayA "<&a>[<&2><&l><&chr[2714]><&r><&a>]"
        - define CommandA "gmc <player.name> accept"
        - define HoverA "<proc[Colorize].context[Permit Gamemode Request For:|Green]><&nl><&r><player.name.display>"
        - define Accept <proc[msgCommand].context[<def[displayA]>|<def[commandA]>|<def[hoverA]>]>
    
        - define DisplayB "<&c>[<&4><&chr[2716]><&c>]"
        - define CommandB "gmc <player.name> decline"
        - define HoverB "<proc[Colorize].context[Decline Gamemode Request For:|Red]><&nl><&r><player.name.display>"
        - define Decline <proc[msgCommand].context[<def[displayB]>|<def[commandB]>|<def[hoverB]>]>
    
        - flag server behrry.essentials.gamemode.requests:->:<player.uuid> duration:3m
        - flag <Player> behrry.essentials.gamemode.request duration:3m
        - narrate targets:<[User]> "<player.name.display> <proc[Colorize].context[is requesting Creative Gamemode.|yellow]>. <[Accept]> <[Decline]>"
    Decline:
        - narrate targets:<[User]> "<&c>Declined <&r><[Requester].name.display><&c>'s request."
        - narrate targets:<[Requester]> "<player.name.display><&c> has declined your request."
    script:
        - if <context.args.get[2]||null> != null:
            - if <player.flag[Behrry.Essentials.Rank]> < 4:
                - define Ranked <server.list_online_players.filter[flag[Behrry.Essentials.Rank].is[less].than[<[Rank].sub[1]>]]>
                - if <context.args.get[2]> == Accept:
                    - define User <context.ars.get[2]>
                    - inject Player_Verification Instantly
                    - if <server.flag[behrry.essentials.gamemode.requests].contains[<[User].uuid>]||false>:
                        - adjust <[User]> gamemode:creative
                        - flag server behrry.essentials.gamemode.requests:<-:<[Requester].uuid>
                        - flag <[User]> behrry.essentials.gamemode.request:!
                        - narrate targets:<[Ranked]> "<player.name.display> <&6>a<&e>ccepted <&r><[User].name.display><proc[colorize].context['s Creative request.|yellow]>"
                        - narrate targets:<[User]> "<player.name.display> <&6>a<&e>ccepted <proc[colorize].context[your Creative request.|yellow]>"
                    - else:
                        - narrate "<[User].name.display> <proc[colorize].context[does not have any open requests.|red]>'"
                - else if <context.args.get[2]> == Decline:
                    - flag server behrry.essentials.gamemode.requests:<-:<[Requester].uuid>
                    - flag <[User]> behrry.essentials.gamemode.request:!
                    - narrate targets:<[Ranked]> "<player.name.display> <&6>d<&e>eclined <&r><[User].name.display><proc[colorize].context['s Creative request.|yellow]>"
                    - narrate targets:<[User]> "<player.name.display> <&4>d<&c>eclined <proc[colorize].context[your Creative request.|red]>"

                - else:
                    - inject Command_Syntax Instantly
            - else:
                - inject Command_Syntax Instantly
        - if <context.args.get[1]||null> == null:
            - define Rank 5
            - if <player.flag[Behrry.Essentials.Rank]> < <[Rank]>:
                - if <player.has_flag[behrry.essentials.gamemode.request]>:
                    - narrate "<proc[Colorize].context[You've already requested Creative Mode.|red]>"
                - else:
                    - define Requested <server.list_online_players.filter[flag[Behrry.Essentials.Rank].is[less].than[<[Rank].sub[1]>]]>
                    - if <[Requested]>.size> != 0:
                        - flag player behrry.essentials.gamemode.request
                        - foreach <[Requested]> as:User:
                            - inject locally Request Instantly
                        - narrate "<proc[Colorize].context[Request for Creative Gamemode submit.|yellow]>"
                    - else:
                        - narrate "<proc[Colorize].context[Nobody online to grant permission.|red]>"
            - else:
                - if <player.gamemode> == creative:
                    - narrate "<proc[Colorize].context[You are already in Creative Mode.|red]>"
                - else:
                    - adjust <player> gamemode:creative
        - else:
            - define Rank 4
            - if <player.flag[Behrry.Essentials.Rank]> < <[Rank]>:
                - inject Permission_Verification Instantly
            - else:
                - if <[User].gamemode> == creative:
                    - narrate "<[User].name.display]> <proc[Colorize].context[is already in Creative Mode.|red]>"
                - else:
                    - define User <context.args.get[1]>
                    - inject Player_Verification
                    - adjust <[User]> gamemode:creative