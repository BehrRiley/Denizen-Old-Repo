Head_Command:
    type: command
    name: head
    description: Gives you a players head, or specify "|Auth" for external
    usage: /head <PlayerName>/<|UUID>/<|AuthID>
    script:
        - if <context.args.get[1]||null> == null || <context.args.get[2]||null> != null:
            - inject Command_Syntax Instantly
        - else:
            - define PlayerName <context.args.get[1]>
            - give player_head[skull_skin=<[PlayerName]>]



            