Temp_Player_Starts_Tutorial_Temp:
  type: yaml_data
  script:
    - teleport <player> <location[2198,102,1793,Runescape50px1]>
    - run Tutorial_Start_Task

Tutorial_Handler:
  type: world
  events:
    on player right clicks with TutorialHandbook:
      # ^ ██ [ Gielinor Guide ] ██
      - if <context.item.is_enchanted>:
        #$██ [ Remove Enchantment ] ██
      - choose <context.item.nbt[Stage]>:
        - case "start":
          #$ ██ [ open book, explain basic game controls ] ██
        - case "OptionsMenu":
          #$ ██ [ open book, explains Options: NPC names visible(ON)|hovering over prayers displays tooltips(ON)|ResourcePack LQ|ResourcePack HQ|Accept Aid|DisableHelp|ProfanityFilter|HouseOptions|music volume ] ██
          - narrate "<&e>In the book, you can now see a variety of game options such as tooltips and music volume. Don't worry about these too much for now, they will become clearer as you explore the game. Talk to the Gielinor guide to continue."
          - flag player Tutorial.Stage:EndFirstEncounter
    on player right clicks oak_door:
      #$ if it's the exit door:
      - if MagicDoor:
        - run Tutorial_Process_Task def:FirstInstructor
      # ^ ██ [ First Instructor ] ██

#-Very first task - give and update book and start reminders
Tutorial_Start_Task:
  type: task
  script:
    - narrate "Before you begin, have  aread through the controls guide in your handbook. When you're ready to get started, click on the Gielinor Guide, or just say hi to him. He is indicated by a flashing yellow arrow."
    - flag player Tutorial.Start
    - give TutorialHandBook
    - run Tutorial_Reminder_Task def:Start

#-Determines which stage process to order next, starting at Options
Tutorial_Process_Task:
  type: task
  definitions: Stage
  script:
    - choose <[Stage]>:
    # ^ ██ [ Gielinor Guide ] ██
      - case "OptionsMenu"
        - flag player Tutorial.Stage:OptionsMenu
        - run Tutorial_HandBookUpdate_Task def:<[Stage]> instantly
        - run Tutorial_Reminder_Task def:<[Stage]> instantly
      - case "EndFirstEncounter":
        - flag player Tutorial.Stage:<[Stage]>
        - run Tutorial_Reminder_Task def:<[Stage]> instantly
    # ^ ██ [ First Instructor ] ██


Tutorial_Reminder_Task:
  type: task
  definitions: Stage
  script:
    - choose <[Stage]>:
    # ^ ██ [ Gielinor Guide ] ██
      - case "Start":
        - while <player.has_flag[Tutorial.Start]>:
          - if <[Loop_Index].mod[<element[2].mul[<element[60].div[5]>]>]>
            - if !<player.has_flag[Tutorial.ReminderCooldown]>:
              - narrate "<&e>Right-Click on the Gielinor Guide, or just say hi to him. He is indicated by a flashing yellow arrow."
          #$ animate arrow above NPC
          - wait 5t
      - case "OptionsMenu":
        - while <player.flag[Tutorial.Stage]> == 'OptionsMenu':
          - if <[Loop_Index].mod[<element[2].mul[<element[60].div[5]>]>]>
            - if !<player.has_flag[Tutorial.ReminderCooldown]>:
              - narrate "<&e>Right click with the flashing handbook found in your inventory. This will display your options menu"
      - case "EndFirstEncounter":
        - while <player.flag[Tutorial.Stage]> == 'EndFirstEncounter':
          - if <[Loop_Index].mod[<element[2].mul[<element[60].div[5]>]>]>
            - if !<player.has_flag[Tutorial.ReminderCooldown]>:
              - narrate "<&e>To continue, all you need to do is click on the door."
          #$ ██ [ animate highlight around door ] ██
          - wait 5t
      - case "FirstInstructor":
        - while <player.flag[Tutorial.Stage]> == 'FirstInstructor':
          - if <[Loop_Index].mod[<element[2].mul[<element[60].div[5]>]>]>
            - if !<player.has_flag[Tutorial.ReminderCooldown]>:
              - narrate "<&e>Follow the path to the next instructor. Talk to the survival expert to continue the tutorial."
          #$ ██ [ animate path to first instructor, arrow above NPC ] ██
          - wait 5t
    # ^ ██ [ First Instructor ] ██

        
        
        
#
Tutorial_HandBookUpdate_Task:
  type: task
  definitions: Stage
  script:
    #$ ██ [ Adjust Book to be enchanted ] ██
    - choose <[Stage]>:
      - case "OptionsMenu"