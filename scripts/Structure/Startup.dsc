startup:
    type: world
    events:
        on server prestart:
            - foreach <list[Gielinor3]> as:world:
                - createworld <[World]>
            #- foreach <server.list_players>:
            #    - createworld world_<[value].uuid>