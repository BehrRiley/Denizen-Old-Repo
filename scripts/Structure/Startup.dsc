startup:
    type: world
    events:
        on server prestart:
            - foreach <list[Gielinor3|Runescape50px1]> as:world:
                - createworld <[World]>
            #- foreach <server.list_players>:
            #    - createworld world_<[value].uuid>