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
        - if <context.entitiy||> == <server.match_player[behr]>:
          - stop
        - else if <context.cause> == obstruction:
          - determine cancelled