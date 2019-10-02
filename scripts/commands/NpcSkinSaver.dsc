# : original source:
# : https://one.denizenscript.com/denizen/repo/entry/147

npc_skin_save_command:
    type: command
    name: saveskin
    usage: /saveskin <name>
    description: Saves ye skin
    script:
    - inject npc_skin_validate
    - flag server npc.skin.<context.args.get[1].escaped>:<player.selected_npc.skin_blob>;<player.selected_npc.name>

npc_skin_load_command:
    type: command
    name: loadskin
    usage: /loadskin <name>
    description: Loads ye skin
    script:
    - inject npc_skin_validate
    - if !<server.has_flag[npc.skin.<context.args.get[1].escaped>]>:
      - narrate "No skin found"
      - stop
    - adjust <player.selected_npc> skin_blob:<server.flag[npc_skins.<context.args.get[1].escaped>]>

npc_skin_validate:
    type: task
    script:
    - if !<player.has_permission[denizen.saveskin]||<<player.is_op||context.server>>>:
      - narrate "Nope!"
      - stop
    - if <context.args.size> == 0:
      - narrate "/saveskin [name]"
      - stop
    - if <player.selected_npc||null> == null:
      - narrate "Select an NPC!"
      - stop
