# | ███████████████████████████████████████████████████████████
# % ██    /rank - for changing your rank
# | ██
# % ██  [ Command ] ██
Rank_Command:
    type: command
    name: rank
    debug: true
    description: Defines a player's rank.
    usage: /rank <PlayerName> <Rank>
    tab complete:
        - if <context.args.size||0> == 0:
          - determine <server.list_online_players.parse[name]>
        - else if <context.args.size> == 1 && !<context.raw_args.ends_with[<&sp>]>:
          - determine <server.list_online_players.parse[name].filter[starts_with[<context.args.get[1]>]]>

        - define list <list[1|2|3|4|5]>
        - if <context.args.size> == 1 && <context.raw_args.ends_with[<&sp>]>:
          - determine <[list]>
        - else if <context.args.size> == 2 && !<context.raw_args.ends_with[<&sp>]>:
          - determine <[List].filter[starts_with[<context.args.get[2]>]]>
    script:
        - if <context.args.get[1]||null> == null || <context.args.get[3]> != null:
            - inject Command_Syntax Instantly
        - if <context.args.get[2]||null> == null:
            - define Rank <context.args.get[1]>
        - else:
            - define User <context.args.get[1]>
            - define Rank <context.args.get[2]>
            - inject Player_Verification_Offline Instantly
            - if <[User]> == <player>:
                - narrate "You cannot adjust your own rank."
                - stop

        - if <[Rank].is_integer> || <[Rank]> <= <script[Ranks_Format].list_keys>:
            - if <[Rank]> <= <player.flag[behrry.essentials.rank].sub[1]>:
                - flag <[User]||<player>> behrry.essentials.rank:<[Rank]>
            - else:
                #$rank required: <player.flag[behrry.essentials.rank].sub[1]>
                - narrate "You don't have permission to do that."
        - else:
            - narrate "Invalid Rank."

Ranks_Format:
    type: yaml data
    1: <&6><&chr[3016]><&a><&chr[272A]><&6><&chr[3017]>
    2:
    3:
    4:
