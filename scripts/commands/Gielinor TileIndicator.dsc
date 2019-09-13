# | ███████████████████████████████████████████████████████████
# % ██    /SetHome for home controls
# | ██
# % ██  [ Command ] ██
# $ ██  [ TO-DO   ] ██ | furnish script | fix radius arg
TileIndicator_Command:
    type: command
    name: TileIndicator
    aliases:
        - gti
    script:
        - if <player.has_flag[GielinorDevelopment.TileIndicator.Monitor]>:
            - flag player GielinorDevelopment.TileIndicator.Monitor:!
            - narrate removed
        - else:
            - flag player GielinorDevelopment.TileIndicator.Monitor
            - narrate added
            - narrate running...
            - run Tile_Indicator_Task Instantly
            # Def:<context.args.get[1]>