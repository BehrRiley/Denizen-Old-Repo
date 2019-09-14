# | ███████████████████████████████████████████████████████████
# % ██   /npc assignment --set Reldo
# | ██
# % ██ [ NPC Assignment ] ██
Reldo:
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
      - if <player.flag[interacting_npc]||null> == <script.name>:
        - flag player interacting_npc:!
    on click:
      - if <player.flag[interacting_npc]||null> != <script.name>:
        - flag player interacting_npc:<script.name>
      - inject Reldo_Interact path:EngageProcedure Instantly
  interact scripts:
    - Reldo_Interact

# | ██  [ Reldo_Interact Interact Script ] ██
Reldo_Interact:
  type: interact
  debug: true
  EngageProcedure:
    - if <player.flag[Quest.SoA.Stage]||0> < 2:
      - narrate format:npc "<script.yaml_key[d1]>"
      - wait 2s

      - define Options_List "<list[I'm in search of a quest.|Do you have anything to trade?|What do you do?]>"
      - define Trigger_List "<list[Quest|Trade|What]>"
      - inject Trigger_Option_builder Instantly

    - else if <player.flag[Quest.SoA.Stage]> == 1:
      - inject locally AfterBook
    - else if <player.flag[Quest.SoA.Stage]> > 1:
      - inject locally AfterQuest
  steps:
    QuestIntro*:
      chat trigger:
        Searching:
          trigger: "/Search|quest/"
          hide trigger message: true
          script:
            - narrate format:npc "Hmmm, I don't... believe there are any here... Let me think actually..."
            - wait 2s
        Trade:
          trigger: "/anything|trade/"
          hide trigger message: true
          script:
            - narrate format:npc "Only knowledge."
        Chatter:
          trigger: "/what|who/"
          hide trigger message: true
          script:
            - narrate format:npc ""


#$$$$$$$$$$ALL OF THIS BELOW IS DEPRECATED $$$$$$$$$$$$$$$$$$$
  QuestAvailableDialog:
    - narrate format:npc "<script.yaml_key[d1]>"
    - wait 2s
    - run locally opt_loop def:o1 instantly
  SearchingforQuest:
    - narrate format:npc "<script.yaml_key[d2]>"
    - wait 2s
    - run locally opt_loop def:o2 instantly
  ContinueQuest:
    - narrate "Reldo strokes his book and ponders..."
    - wait 5s
    - narrate format:npc "<script.yaml_key[d3]>"
    - flag player Quest.SoA.Stage:1


# ██ [ Quest Declining               ] ██
  NevermindQuest:
  - narrate format:npc "<script.yaml_key[d4]>"
  - wait 2s
  - run locally opt_loop def:o3 instantly
  YeahNevermindQuest:
  - narrate format:npc "<script.yaml_key[d5]>"
  - flag player interacting_npc:!
  - flag player sig:!


# ██ [ Non-Quest Dialog              ] ██
  GrapesContinued:
  - narrate format:npc "<script.yaml_key[d8]>"
  - wait 2s
  - narrate format:npc "<script.yaml_key[p2]>"
  GrapesEnd:
  - narrate format:npc "<script.yaml_key[d9]>"
  - flag player interacting_npc:!
  - flag player sig:!


  WhatchyaDo:
  - narrate format:npc "<script.yaml_key[d10]>"
  - wait 2s
  - run locally opt_loop def:o7 instantly
  ALibraryOfCourse:
  - narrate format:npc "<script.yaml_key[d11]>"
  - flag player interacting_npc:!
  - flag player sig:!


# ██ [ Quest Progression 2           ] ██
  AfterBook:
  - narrate format:npc "<script.yaml_key[d1]>"
  - wait 2s
  - run locally opt_loop def:o4 instantly
  AfterBookContinue:
  - narrate format:npc "<script.yaml_key[d6]>"
  - wait 2s
  - narrate format:player "<script.yaml_key[p1]>"
  
# ██ [ Non-Quest Dialog After Quest  ] ██
  AfterQuest:
  - narrate format:npc "<script.yaml_key[d1]>"
  - wait 2s
  - run locally opt_loop def:o5 instantly

  #ScriptName:
  #- narrate format:npc "<script.yaml_key[]>"
  #- wait 2s
  #- run locally opt_loop def:o instantly


# ███████████████████████████████████████████████████████████
# ██   Custom script paths to be injected/run
# ██
# ██   [ Option Selections ]
  o1:
  - "SearchingforQuest/<&a>I'm in search of a quest."
  - "GotanyGrapes/<&a>Do you have anything to trade?"
  - "WhatchyaDo/<&a>What do you do?"

  o2:
  - "ContinueQuest/<&a>Thank you."
  - "NevermindQuest/<&a>On second thoughts, I don't want a quest after all"

  o3:
  - "YeahNevermindQuest/<&a>I was. I am. I changed my mind."
  - "ContinueQuest/<&a>I am, actually. What were you saying again?"

  o4:
  - "GotanyGrapes/<&a>Do you have anything to trade?"
  - "WhatchyaDo/<&a>What do you do?"
  - "AfterBookContinue/<&a>Ok. I've read the book. Do you know where I can find the Phoenix Gang?"

  o5:
  - "GotanyGrapes/<&a>Do you have anything to trade?"
  - "WhatchyaDo/<&a>What do you do?"

  o6:
  - "GrapesContinued/<&a>How much would you like for that then?"
  - "GrapesEnd/<&a>Goodbye then."

  o7:
  - "ALibraryOfCourse/<&a>Ah, That's why you're in a library then."
  - "GrapesEnd/<&a>Goodbye then."



# ███████████████████████████████████████████████████████████
# ██   Dialog Transcripts to be narrated
# ██
# ██ [ Reldo dialogue ] ██
  d1: "Hello stranger."
  d2: "Hmmm, I don't... believe there are any here... Let me think actually..."
  d3: "Ah, yes. I know. If you look in a book called 'The Shield of Arrav', you'll find a quest in there. I'm not sure  where    the book is mind you... but I'm sure it's around here somewhere."
  d4: "Oh. But you said you're in search of a quest."
  d5: "You perplex me. Well, come back if you change your mind again."
  d6: "No, I don't. I think I know someone who might however. If I were you I would talk to Baraek, the fur trader in the market place. I've heard he has connections with the Phoenix Gang."
  d7: "Only knowledge."
  d8: "No, sorry, that was just my little joke. I'm not the trading type."
  d9: "Until next time."
  d10: "I am the palace librarian."
  d11: "Yes. Although i would probably be in here even if i didn't work here. I like reading. Someday i hope to catalogue all of the information stored in these books so all may read it."
# ██ [ Player dialogue ] ██
  p1: "Thanks, I'll try that!"
  p2: "Ah well."
