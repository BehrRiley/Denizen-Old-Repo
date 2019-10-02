World_Command:
    type: command
    name: world
    debug: false
    description: Teleports you to the specified world.
    usage: /world <WorldName>
    tab complete:
        - if <context.args.size||0> == 0:
            - determine <server.list_worlds.parse[name].exclude[Runescape50px1]>
        - else if <context.args.size> == 1 && !<context.raw_args.ends_with[<&sp>]>:
            - determine <server.list_worlds.parse[name].exclude[Runescape50px1].filter[starts_with[<context.args.get[1]>]]>
    script:
        - if <context.args.get[1]||null> == null || <context.args.get[2]||null> != null:
            - inject Command_Syntax Instantly
        - teleport <player> <world[<context.args.get[1]>].spawn_location>
        - narrate "<proc[Colorize].context[You were teleported to world:|green]> <context.args.get[1]>"
