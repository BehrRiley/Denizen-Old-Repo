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
        - adjust <player> display_name:<player.flag[behrry.essentials.display_name]>