# | ███████████████████████████████████████████████████████████
# % ██    /home name takes you to your home.
# | ██
# % ██  [ Command ] ██
# $ ██  [ TO-DO   ] ██ | furnish script | tab complete GUI for homes on blank | transform flags into notable to make homes unique
Home_Command:
    type: command
    name: home
    debug: false
    description: Teleports you to a home.
    aliases:
      - h
      - homes
    usage: /home <HomeName> (Remove)
    tab complete:
        - if <context.args.size||0> == 0:
          - determine <player.flag[behrry.essentials.homes.name]||>
        - else if <context.args.size> == 1 && !<context.raw_args.ends_with[<&sp>]>:
            - determine <player.flag[behrry.essentials.homes.name].filter[starts_with[<context.args.get[1]>]]||>
        - else if <context.args.size> == 1 && <context.raw_args.ends_with[<&sp>]>:
            - determine "remove"
        - else if <context.args.size> == 2 && !<context.raw_args.ends_with[<&sp>]>:
            - determine "remove"
    script:
        - if <context.args.get[1]||null> == null || <context.args.get[3]||null> != null:
            #- define Title "My Homes"
            #- define HCount <player.flag[behrry.essentians.homes.name].size>
            #- if <[HCount].div[9].round_up.add[1]> > 5:
            #    - define size 5
            #    - define Title "<[Title]> "
            #- else:
            #    - define Size <[HCount].div[9].round_up.add[1]>
            #- define SoftMenu <list[<[SelectHomes]>|<[Delete]>|<[ReLocate]>|<[ChangeDirection]>|<[Guide]>|<[WhereIs]>]>
            #- note "in@generic[title=<[title]>;size=<[Size]>]" as:<player>HomeGUI
            #- inventory open d:HomeGUI
            - inject Command_Syntax Instantly
        - if !<player.has_flag[behrry.essentials.homes.name]>:
            - narrate "<proc[Colorize].context[You have no homes.|red]>"
            - stop
        - if <context.raw_args.split[<&sp>].filter[is[==].to[remove]].size> == 2:
            - narrate "<proc[Colorize].context[Nothing interesting happens.|yellow]>"
            - stop
        - if <context.args.size> == 2 && <context.raw_args.split[<&sp>].filter[is[==].to[remove]].size> == 0:
            - inject Command_Syntax Instantly

        - define Name <context.raw_args.split[<&sp>].filter[is[==].to[remove].not].get[1]||null>
        - define Ref <player.flag[behrry.essentials.homes.name].find[<[Name]>]||null>
        - define Location <player.flag[behrry.essentials.homes.location].get[<[Ref]>].as_location||null>
        
        - if <context.args.get[1]||null> == remove || <context.args.get[2]||null> == remove:
            - if <player.flag[behrry.essentials.homes.name].contains[<[Name]>]>:
                - narrate "<proc[Colorize].context[Home Removed.|green]>"
                - flag player behrry.essentials.homes.name:<-:<[Name]>
                - flag player behrry.essentials.homes.location:<-:<[Location]>
            - else:
                - narrate "<proc[Colorize].context[That home does not exist.|red]>"
        - else:
            - if <player.flag[behrry.essentials.homes.name].contains[<[Name]>]>:
                - flag <player> behrry.essentials.teleport.back:<player.location>
                - teleport <player> <[Location]>
                - narrate "<proc[Colorize].context[Teleported to:|green]> <&e><player.flag[behrry.essentials.homes.name].get[<[Ref]>]>"
            - else:
                - narrate "<proc[Colorize].context[That home does not exist.|red]>"

#HomeGUI_Handler:
 #   type: world
 #   events:
 #       on player opens inventory:
 #       on player closes inventory:
 #       on player clicks in inventory:
 #       on player drags in inventory: