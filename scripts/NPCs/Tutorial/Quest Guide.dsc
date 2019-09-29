# | ███████████████████████████████████████████████████████████
# % ██   /npc assignment --set Quest Guide
# | ██
# % ██ [ Assignment Script ] ██
Quest Guide:
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
    - inject "Quest Guide_Interact" "path:steps.greeting.chat trigger.greet.script" Instantly
  interact scripts:
  - "Quest Guide_Interact"

# | ██  [ Quest Guide Interact Script ] ██
Quest Guide_Interact:
  type: interact
  debug: false
  steps:
    Greeting*:
      chat trigger:
        Greet:
          trigger: /Hi|Hello|Howdy|Hey/
          hide trigger message: true
          script:
            - zap next
    #        u1: It's time to learn about quests! Just talk to the quest guide to get started.
    #        d2: Ah. Welcome, adventurer. I'm here to tell you all about quests. Let's start by opening your quest journal.
    #        u3: Click on the flashing icon to the left of your inventory
    #next:
    #  chat trigger:
    #    before click book:
    #    - Have you not opened that menu yet?
    #    after:
    #        u4: This is your quest journal. It lists every quest in the game. Talk to the quest guide again for an explaination on how it works.
    #        d5: now you have the journal open, I'll tell you a bit about it. At the moment all of the quests are shown in red, which means you have not started them yet.
    #        d6: When you start a quest, it will change the color to yellow. Once you've finished it, it will change to green. This is so you can easily see what's complete, what's started, and what's left to begin.
    #        d7: Clicking a quest in the journal will display some more information on it. If you havent started the quest, it will tell you where to begin and what requirements you need.
    #        d8: if the quest is in progress, it will remind you what to do next.
    #        d9: It's very easy to find quest start points. Just look out for the quest icon in your minimap. You should see one marking this house.
    #    next:
    #        u10: The minimap in the top right corner of the screen has various icons to show different points of interest. Look for the iccon to the left to find quest start points.
    #        d11: The quests themselves can vary greatly from collecting beads to hunting down dragons. Completing quests will reward you will all sorts of things, such as new areas and better weapons!
    #        d12: There's not a lot more i can tell youn about questing. You have to experience the thrill of it yourself ot fully understand. Let me know if you want a recap, otherwise you can move on.
    #        u13: It's time to enter some caves. Click on the ladder to go down to the next area.
    #    final:
    #        u14: Would you like to hear about quests again
    #        - Yes!
    #            d15: If you open your quest journal you will see that all of the quests are shown in red at the moment. This means you have not started them yet.
    #            d6-d12:
    #        - Nope, i'm ready to move on!
    #            d16: okay then.
#