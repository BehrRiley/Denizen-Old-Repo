# | ███████████████████████████████████████████████████████████
# % ██    /SetHome for home controls
# | ██
# % ██  [ Command ] ██
# $ ██  [ TO-DO   ] ██ | furnish script | tab complete GUI for homes on blank, check for enemies near? GOOD IDEA FOR SETTINGS | Suggest good names based on location
SetHome_Command:
    type: command
    name: sethome
    debug: true
    description: Sets a home location.
    aliases:
        - seth
    usage: /sethome <HomeName>
    tab complete:
        - if <player.has_flag[behrry.essentials.homes.name]>:
            - if <context.raw_args.contains_any[<player.flag[behrry.essentials.homes.name]>]>:
                - determine "<proc[Colorize].context[This Home Exists Already!|red]>"
    script:
        - if <context.args.get[1]||null> || <context.args.get[2]||null> != null:
            - inject Command_Syntax Instantly
        - define Name <context.args.get[1]||null>
        - if <player.flag[behrry.essentials.homes.name].contains[<[Name]>]||null>:
            - narrate "<proc[Colorize].context[This home name already exists.|red]>"
        - else:
            - if <[Name].matches[[a-zA-Z0-9-_]+]>:
                - flag <player> behrry.essentials.homes.name:->:<context.args.get[1]>
                - flag <player> behrry.essentials.homes.location:->:<player.location.simple.as_location.add[0.5,0,0.5].with_yaw[<player.location.yaw>].with_pitch[<player.location.pitch>]>
                - narrate "<proc[Colorize].context[New home set:|green]> <&e><context.args.get[1]>"
            - else:
                - narrate "<proc[Colorize].context[Home names should only be alphanumerical.|red]>"