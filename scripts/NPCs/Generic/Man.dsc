# | ███████████████████████████████████████████████████████████
# % ██   Assignment Script
# | ██
# % ██ [ /npc assignment --set NPC_Name ] ██
Man:
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
  interact scripts:
    - Man_Interact

# | ██  [ NPC_Name Interact Script ] ██
Man_Interact:
  type: interact
  debug: false
  steps:
    Normal:
      chat trigger:
        1:
          trigger: "Do you wish to /trade/?"
          hide trigger message: true
          script:
            - narrate format:player "<context.message>"
            - wait 2s
            - narrate format:npc "<script.yaml_key[d2]>"
            - wait 10s
            - flag player interacting_npc:!
        2:
          trigger: "I'm in search of a /quest/."
          hide trigger message: true
          script:
            - narrate format:player "<context.message>"
            - wait 2s
            - narrate format:npc "<script.yaml_key[d3]>"
            - wait 10s
            - flag player interacting_npc:!
        3:
          trigger: "I'm in search of enemies to /kill/."
          hide trigger message: true
          script:
            - narrate format:player "<context.message>"
            - wait 2s
            - narrate format:npc "<script.yaml_key[d4]>"
            - wait 10s
            - flag player interacting_npc:!
      click trigger:
        script:
          - if <player.flag[interacting_npc]> == <script.name>:
            - flag player interacting_npc:<script.name>

          - choose <util.random.int[1].to[6]>:
            - case 1:
              - narrate format:npc "<script.yaml_key[d1]>"
              - wait 2s

              - define Options_List "<list[Do you wish to trade?|I'm in search of a quest.|I'm in search of enemies to kill.]>"
              - define Trigger_List "<[Options_List]>"
              - inject Trigger_Option_builder Instantly

            - case 2:
              - narrate format:player "<script.yaml_key[p2]>"
              - wait 2s

              - narrate format:npc "<script.yaml_key[d5]>"

            - case 3:
              - narrate format:npc "<script.yaml_key[d6]>"
              - wait 2s

              - narrate format:player "<script.yaml_key[p3]>"

            - case 4:
              - narrate format:npc "<script.yaml_key[d7]>"
              - wait 2s

              - narrate format:player "<script.yaml_key[p4]>"

            - case 5:
              - narrate format:npc "<script.yaml_key[d8]>"
              - wait 2s
              - attack <player> target:<npc>

            - case 6:
              - narrate format:npc "<script.yaml_key[d<util.random.int[9].to[17]>]>"

          - flag player interacting_npc:!

# | ███████████████████████████████████████████████████████████
# % ██   Dialog Transcripts to be narrated
# | ██
# % ██ [ NPC dialogue ] ██
  d1: "How can i help you?"
  d2: "No. i have nothing i wish to get rid of. If you want to do some trading, there are plenty of shops and market stalls around though."
  d3: "I'm sorry i can't help you there."
  d4: "I've heard there are many fearsome creatures that dwell under the ground..."
  d5: "I'm sorry i can't help you there."
  d6: "Not to bad, but I'm a little worried about the increase of goblins these days."
  d7: "I'm fine, how are you?"
  d8: "Are you asking for a fight?"
  d9: "I'm very well thank you."
  d10: "Get out of my way, I'm in a hurry!"
  d11: "Hello there! Nice weather we're having."
  d12: "Hello."
  d13: "I'm a little worried - I've heard theres lots of people going about, killing citizens at random."
  d14: "Yo, wassup!"
  d15: "I think we need a new king. The one we've got isn't very good."
  d16: "I'm busy right now."
  d17: "No, i don't want to buy anything!"

# | ██ [ Player dialogue ] ██
  p1: "hello, how's it going?"
  p2: "I'm in search of a quest."
  p3: "don't worry, I'll kill them."
  p4: "Very well thank you."
