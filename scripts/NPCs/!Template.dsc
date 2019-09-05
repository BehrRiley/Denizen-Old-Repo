# | ███████████████████████████████████████████████████████████
# % ██   /npc assignment --set NPC_Name
# | ██
# % ██ [ Assignment Script ] ██
NPC_Name:
  type: assignment
  debug: true
  actions:
    on assignment:
      - trigger name:click state:true
      - trigger name:proximity state:true radius:4
      - if <server.has_flag[npc.skin.<script.name>]>:
        - adjust <npc> skin_blob:<server.flag[npc.skin.<script.name>]>
      - else:
        - narrate "<proc[Colorize].context[No NPC skin saved for:|red]> <&6>'<&e><script.name><&6>'"
    on exit proximity:
      - if <player.flag[interacting_npc]> == <script.name>:
        - flag player interacting_npc:!
    on click:
      - if <player.flag[interacting_npc]> != <script.name>:
        - flag player interacting_npc:<script.name>
      - inject Reldo_Interact path:EngageProcedure Instantly
  interact scripts:
    - NPC_Name_Interact

# | ██  [ NPC_Name Interact Script ] ██
NPC_Name_Interact:
  type: interact
  debug: false
  GenericGreeting:
    - narrate format:npc "Hello."
    - wait 2s

    - define Options_List "<list[|||]>"
    - define Trigger_List "<list[|||]>"
    - inject Trigger_Option_builder Instantly
  steps:
    1:
      chat trigger:
        1:
          trigger: "//"
          hide trigger message: true
          script:
            - narrate format:npc ""
            - flag player interacting_npc:!
        2:
          trigger: "//"
          hide trigger message: true
          script:
            - narrate format:npc ""
            - flag player interacting_npc:!
        3:
          trigger: "//"
          hide trigger message: true
          script:
            - narrate format:npc ""
            - flag player interacting_npc:!
        4:
          trigger: "//"
          hide trigger message: true
          script:
            - narrate format:npc ""
            - flag player interacting_npc:!
