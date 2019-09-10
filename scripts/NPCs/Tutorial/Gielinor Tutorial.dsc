# | ███████████████████████████████████████████████████████████
# % ██   /npc assignment --set Gielinor Guide
# | ██
# % ██ [ Assignment Script ] ██
Gielinor Guide:
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
    - inject "Gielinor Guide_Interact" "path:steps.greeting.chat trigger.greet.script" Instantly
  interact scripts:
  - "Gielinor Guide_Interact"

# | ██  [ Gielinor Guide Interact Script ] ██
Gielinor Guide_Interact:
  type: interact
  debug: false
  steps:
    Greeting*:
      chat trigger:
        Greet:
          trigger: /Hi|Hello|Howdy|Hey/
          hide trigger message: true
          script:
            - zap ExperienceCheck
            - narrate format:player "<context.trigger||Hi>"
            - narrate format:npc "Greetings! I see you are a new arrival to the world of Gielinor."
            - wait 2s
            - narrate format:npc "My job is to welcome all new visitors. So welcome! You have already learned the first thing eded to succeed in this world: Talking to other people!"
            - wait 2s
            - narrate format:npc "You will find many inhabitants of this world have useful things to say to you. By clicking on them you can talk to them."
            - wait 2s
            - narrate format:npc "Before we get going, if you could be so kind to let me know how much experience you have the Old School Runescape, that would be wonderful."
            - wait 2s
            - narrate "<&e>To answer, simply click your chosen answer on the following screen or try saying it aloud."
            - wait 2s

            - define Options_List "<list[I've played in the past, but not recently.|I am an experienced player.|I am brand new! This is my first time here.]>"
            - define Trigger_List "<list[past|experienced|new]>"
            - inject Trigger_Option_builder Instantly
    ExperienceCheck:
      click trigger:
        script:
          - if !<player.has_flag[Tutorial.ReminderCooldown]>:
            - flag player Tutorial.ReminderCooldown duration:10s
            - narrate "<&e>To answer, simply click your chosen answer on the following screen or try saying it aloud."
            - wait 2s

            - define Options_List "<list[I've played in the past, but not recently.|I am an experienced player.|I am brand new! This is my first time here.]>"
            - define Trigger_List "<list[past|experienced|new]>"
            - inject Trigger_Option_builder Instantly
      chat trigger:
        1:
          trigger: /past|experienced|new/ /master|expert|always|before|never|once|twice|no/
          hide trigger message: true
          script:
            - zap OptionsMenu
            - choose <context.trigger>:
              - case "past" "before" "once" "twice:"
                - flag server osrsexperiencepoll.neutral:++
              - case "New" "Never" "no":
                - flag server osrsexperiencepoll.new:++
              - case "experienced" "master" "expert" "always":
                - flag server osrsexperiencepoll.experienced:++
            - narrate format:npc "Wonderful! Thank you."
            - wait 2s
            - narrate format:npc "Now then, let's start by looking at your options menu."
            - wait 2s
            - narrate "<&e>Click your handbook to reveal the Options Menu."
            - run Tutorial_Process_Task def:OptionsMenu Instantly
    OptionsMenu:
      click trigger:
        script:
          - if <player.flag[Tutorial.Stage]> == EndFirstEncounter:
            - zap EndFirstEncounter
            - narrate format:NPC "Looks like you're making good progress! The menu you just opened is one of many. You'll learn about the rest  you progress through the tutorial."
            - wait 2s
            - narrate format:npc "Anyway, i'd say it's time for you to go and meet your first instructor!"
            - wait 2s
            - narrate "<&e>It's time to meet your first instructor. To continue, all you need to do is click on the door.
            - run Tutorial_Process_Task def:EndFirstEncounter Instantly
    EndFirstEncounter:
      click trigger:
        script:
          - if !<player.has_flag[Tutorial.ReminderCooldown]>:
            - flag player Tutorial.ReminderCooldown duration:10s
            - narrate "<&e>To continue, all you need to do is click on the door."
    End:
      click trigger:
        script:
          - Narrate format:npc "Please seek your further instructors now."
