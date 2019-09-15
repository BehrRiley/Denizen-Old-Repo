yamlreload_Command:
    type: command
    name: yamlreload
    debug: false
    aliases:
        - yreload
    script:
        - yaml id:<player> unload
        - yaml id:<player> load:data/pData/<player.uuid>.yml
        - narrate "<proc[Colorize].context[Player Yaml File reloaded.|green]>"