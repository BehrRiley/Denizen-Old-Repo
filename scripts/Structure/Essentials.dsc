# | ███████████████████████████████████████████████████████████
# % ██   Essentials Main Structure
# | ██
# % ██  [ Chat Management ] ██
# $ ██  [ To-Do ]           ██
Essentials:
    type: world
    debug: false
    events:
      on player chats:
        - determine passively cancelled
        - if <player.has_flag[Interacting_NPC]>:
          - stop
        - announce "<player.name.display><&r>: <context.message.parse_color>"
      on player logs in:
        - wait 1t
        - choose <player.flag[behrry.rank]>:
          - case "5":
            - adjust <player> display_name:<player.flag[behrry.essentials.display_name]>
          - case "1":
            - adjust <player> "display_name:<&6><&chr[3016]><&a><&chr[272A]><&6><&chr[3017]><player.flag[behrry.essentials.display_name]>"
        - if !<player.has_flag[behrry.rank]>:
          - flag <player> behrry.rank:5
      on hanging breaks:
        - if <context.entitiy||> == <server.match_player[behr]||>:
          - stop
        - else if <context.cause> == obstruction:
          - determine cancelled
      on player kicked:
        - if <context.reason> == "Illegal characters in chat":
          - determine cancelled


testhold:
  type: world
  events:
    on player dies:
      - flag player behrry.essentials.teleport.deathback:<player.location>
      - define key Behrry.Essentials.Cached_Inventories
      - define YamlSize <yaml[<player>].read[<[Key]>].size||0>
      - define UID <yaml[<player>].read[<[Key]>].get[<[YamlSize]>].before[Lasagna]||0>
      - if <[YamlSize]> > 9:
        - foreach <yaml[<player]>].read[<[Key]>].get[1].to[<[YamlSize].sub[9]>]>:
          - yaml id:<player> set <[Key]>:<-:<[Value]>
      - yaml id:<player> set <[Key]>:->:<[UID].add[1]>Lasagna<context.inventory.list_contents>
      - yaml id:<player> savefile:data/pData/<player.uuid>.yml




     # on tab complete priority:lowest:
     #   - define Commands <server.list_scripts.filter[ends_with[_command]]>
     #   - if !<[Commands].contains[<context.command>]>:
     #     - determine cancelled