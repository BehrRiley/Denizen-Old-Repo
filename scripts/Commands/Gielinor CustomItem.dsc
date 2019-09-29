CustomItem_Command:
    type: command
    name: customitem
    aliases:
        - ci
    tab complete:
        - if <context.args.size> == 0:
            - determine <list[item|weapon]>
        - else if <context.args.size> == 1 && <context.raw_args.ends_with[<&sp>]>:
            - determin <list[item|weapon].starts_with[<context.args.get[1]>]>
    script:
        - define Num <context.args.get[2]>
        - choose <context.args.get[1]>:
            - case "item":
                - define Type i@music_disc_11
            - case "weapon":
                - define Type i@wooden_sword
        - give <[Type]>[custom_model_data=<[Num]>]