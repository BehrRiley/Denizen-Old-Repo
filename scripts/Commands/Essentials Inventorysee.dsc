inventorysee_Command:
    type: command
    name: inventorysee
    debug: false
    description: Views another player's inventory
    aliases:
      - invsee
      - inv
    use: "<proc[colorize].context[/inventorysee <&lt>inventoryseeName<&gt> (Remove)|yellow]>"
    tab complete:
        - if <context.args.size||0> == 0:
          - determine <server.list_online_players.parse[name]>
        - else if <context.args.size> == 1 && !<context.raw_args.ends_with[<&sp>]>:
            - determine <server.list_online_players.parse[name].filter[starts_with[]]||>
    script:
        - if <context.args.get[1]||null> == null || <context.args.get[2]||null> != null:
            - inject Command_syntax instantly
        - define User <context.args.get[1]>
        - inject Player_Verification_Offline Instantly
        - if <[User]> != <player>:
            - inventory open d:<[User].inventory>
        - else:
            - define Reason "You cannot edit your own inventory."
            - inject Command_Error Instantly