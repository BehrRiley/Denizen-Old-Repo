tablist:
    type: world
    debug: false
    header:
      - "<&b><&m><element[].pad_left[40].with[-]>"
      - "<&f>Welcome to <&6>Gielinor!"
      - "<&7>Players Online<&co> <&6>[<&f><server.list_online_players.size><&6>/<&f><server.max_players><&6>]<&f>    <&7>Ping<&co> <&6>[<&f><[value].ping><&6>]"
      - "<&b><&m><element[].pad_left[40].with[-]>"
    footer:
      - "<&b><&m><element[].pad_left[40].with[-]>"
      - "<&7>World<&co> <&6>[<&f><[value].world.name><&6>]<&f>         <&7>Coins<&co> <&6>[<&f><[value].money.as_money.format_number||0><&6>]"
      - "<&7>Time<&co> <&6>[<&f><util.date.time.hour><&6><&co><&f><util.date.time.minute><&6><&co><&f><util.date.time.second><&6>]         "
      - "<&b><&m><element[].pad_left[40].with[-]>"
    events:
      on delta time secondly every:5:
        - foreach <server.list_online_players>:
          - if <context.second.mod[2]> == 1:
            - adjust <[value]> "player_list_name:<[value].name>"
          - else:
            - adjust <[value]> "player_list_name:<[value].name.display.parse_color>"
          - define header "<script.yaml_key[header].separated_by[<&nl>].parsed>"
          - define footer "<script.yaml_key[footer].separated_by[<&nl>].parsed>"
          - adjust <[value]> tab_list_info:<[header]>|<[footer]>