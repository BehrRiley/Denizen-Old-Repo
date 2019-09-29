yamlreload_Command:
    type: command
    name: yamlreload
    debug: true
    FileDirectories:
        Player: data/pData/<player.uuid>.yml
        QuestData: data/QuestData.yml
    tab complete:
        - define List <script.list_keys[FileDirectories]>
        - if <context.args.get[1]||null> == null:
            - determine <[List]>
        - if <context.args.size> == 1 && !<context.raw_args.ends_with[<&sp>]>:
        - determine <[List].filter[starts_with[<context.args.get[1]>]]>
    use: /yamlreload <&lt>yamlname<&gt>
    aliases:
        - yreload
        - yr
    script:
        - if <context.args.get[1]||null> == null:
            - narrate "<proc[Colorize].context[Reload error: null|red>"
            - inject Command_Usage Instantly
        - else if <context.args.get[2]||null> != null:
            - narrate "<proc[Colorize].context[Reload error: too many args|red>"
            - inject Command_Usage Instantly

        - define list <script.list_keys[FileDirectories]>
        - if <context.args.get[1]> == player:
            - if !<server.list_files[data/pData/].contains[<player.uuid>.yml]>:
                - yaml id:<player> create
                - yaml id:<player> savefile:data/pData/<player.uuid>.yml
            - else:
                - yaml id:<player> unload
                - yaml id:<player> load:data/pData/<player.uuid>.yml
        - else if <[List].contains[<context.args.get[1]>]>:
            - if !<server.list_files[data/].contains[<context.args.get[1]>.yml]>:
                - yaml id:<context.args.get[1]> create
                - yaml id:<context.args.get[1]> savefile:<script.yaml_key[FileDirectories.<context.args.get[1]>]>
            - else:
                - yaml id:<context.args.get[1]> unload
                - yaml id:<context.args.get[1]> load:<script.yaml_key[FileDirectories.<context.args.get[1]>]>
                - narrate "<proc[Colorize].context[Player Yaml File reloaded.|green]>"
        - else:
            - narrate "<proc[Colorize].context[Reload error: Invalid Yaml.|red>"
            - inject Command_Usage Instantly

# | ███████████████████████████████████████████████████████████
# % ██    Player Data Management
# | ██
# % ██  [ Events ] ██
QuestDataManager:
  type: world
  debug: false
  events:
    on player logs in:
      - if !<server.list_files[data/].contains[QuestData]>:
        - yaml id:<player> create
        - yaml id:<player> savefile:data/QuestData.yml
      - else:
        - yaml id:<player> load:data/QuestData.yml
