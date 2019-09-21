startup:
    type: world
    events:
        on server prestart:
            - run WorldLoad_Task
            #- foreach <server.list_players>:
            #    - createworld world_<[value].uuid>
WorldLoad_Task:
    type: task
    debug: false
    script:
        - foreach <list[Gielinor3|Runescape50px1]> as:world:
            - createworld <[World]>