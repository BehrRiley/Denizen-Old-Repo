# | ███████████████████████████████████████████████████████████
# % ██    /npc assignment --set BankerNPC
# | ██
# % ██  [ Assignment Script ] ██
Banker:
  type: assignment
  debug: false
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
      - if <player.flag[interacting_npc]> == <script.name>:
        - flag player interacting_npc:<script.name>
      
      #- if <player.has_flag[GrandExchange.collection.alert]>:
      #  - narrate format:npc "Good day. Before we go any further, I should inform you that you have items ready for collection from the Grand Exchange. How may i help you?"
      #- else:
      - narrate format:npc "Good day. How may i help you?"
      - inject locally GenericGreeting Instantly
  GenericGreeting:
    - wait 2s
    #- define Options_List "<list[I'd like to access my bank account, please|I'd like to check my pin settings|i'd like to see my collection box|What is this place?]>"
    - define Options_List "<list[I'd like to access my bank account, please|What is this place?]>"
    - define Trigger_List "<list[access|pin|collection|place]>"
    - inject Trigger_Option_builder Instantly
  interact scripts:
    - Banker_Interact

# | ██  [ Banker Interact Script ] ██
Banker_Interact:
  type: interact
  debug: false
  steps:
    Normal*:
      chat trigger:
        Bank:
          trigger: "/access|bank|account/"
          hide trigger message: true
          script:
            - flag player interacting_npc:!
            - run open_bank instantly
        Pin:
          trigger: "/check|pin|settings/"
          hide trigger message: true
          script:
            - flag player interacting_npc:!
            - narrate format:npc "The banking PIN security system currently is not implented it appears actually, sorry. Please try again later."
        Collection:
          trigger: "/collection|box/"
          hide trigger message: true
          script:
            - flag player interacting_npc:!
            - narrate format:npc "The Grand Exchange currently is not implented it appears actually, sorry. Please try again later."
        Location:
          trigger: "/what|where|place/"
          hide trigger message: true
          script:
            - narrate format:npc "this is a branch of the bank of Runescape. We have branches in many towns."
            - define Options_List "<list[And what do you do?|didn't you used to be called the Bank of Varrock?]>"
            - define Trigger_List "<list[what|Varrock]>"
            - inject locally option_builder instantly
    Inquire:
      chat trigger:
        Introduction:
          trigger: "/what|do/"
          hide trigger message: true
          script:
            - narrate format:npc "We will look after your items and money for you. Leave your valuables with us if you want to keep them safe."
            - inject Banker path:GenericGreeting Instantly
        Location:
          trigger: "/called|varrock/"
          hide trigger message: true
          script:
            - narrate format:npc "Yes we did, but people kept on coming into our branches outside of Varrock and telling us that our signs were wrong. They acted as if we didn't know what town we were in or something."
            - inject Banker path:GenericGreeting Instantly
