# | ███████████████████████████████████████████████████████████
# % ██   /npc assignment --set Survival Instructor
# | ██
# % ██ [ Assignment Script ] ██
Survival Instructor:
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
    - inject "Survival Instructor_Interact" "path:steps.greeting.chat trigger.script" Instantly
  interact scripts:
  - "Survival Instructor_Interact"

# | ██  [ Survival Instructor Interact Script ] ██
Survival Instructor_Interact:
  type: interact
  debug: false
  steps:
    Greeting*:
      click trigger:
        script:
          d1: "Hello there, newcomer. My name is Brynna. My job is to teach you about the skills you can use to survive in this world."
          d2: "The first skill we're going to look at is Fishing. There's some shrimp in this pond here. Let's try and catch some."
          u3: "- gives you a small fishing yet -"
      chat trigger:
        Greet:
          trigger: /Hi|Hello|Howdy|Hey/
          hide trigger message: true
          script:
            d1: "Hello there, newcomer. My name is Brynna. My job is to teach you about the skills you can use to survive in this world."
            d2: "The first skill we're going to look at is Fishing. There's some shrimp in this pond here. Let's try and catch some."
            u3: "- gives you a small fishing yet -"
#    GivenItem:
#      click trigger:
#        script:
#          - same
#      chat trigger:
#        script:
#          - if not weild yet:
#            d2: "Hello again. First up, we're going to do some fishing. There's some shrimp in this pond here. Let's try and catch some."
#          - else once held:
#         #$ ZAP NEXT
#          u4: "to view the item you've been given, you'll need to open your inventory. To do so, click on the flashing backpack icon to the right hand side of your screen."
#          u5: "This is your inventory. You can view all of your items here, including the net youve just beeen given. Lets use it to catch some shrimp. To start fishing, just click on the sparkling fishing spot, indicated by the flashing arrow."
#    CatchShrimp:
#      click trigger:
#        script:
#        script:
#          - if no shrimp yet:
#            d2: "Hello again. First up, we're going to do some fishing. There's some shrimp in this pond here. Let's try and catch some."
#          - else if attempted shrimp:
#            #$" you're now attempting to fish some shrimp. Sit back and wait while you catch some."
#              - you manage to catch some shrimp
#              - now open your skills menu
#              u6: "On this menu, you can view your skills. Your skills can be leveled up by earning experience, which is gained by performing various activities. As you level up your skills, you will earn new unlocks. Speak to the survival expert to continue."
#            #$GAP - WHAT IF I CLICK BEFORE I CHECK INVENTORY?
#    TaskTwo:
#      click trigger:
#        script:
#          first:
#            p7: "I managed to catch some shrimp."
#            d8: "Excellent work. Now that you have some shrimp, you're going to want to cook them. To do that, you'll need a fire. that brings us on to the woodcutting and firemaking skills."
#            u9: "the survival expert gives you a bronze axe and a tinderbox."
#            u10: "It's time to cook your shrimp. However, you require a fire to do that which means you need some logs.  You can cut down trees using your woodcutting skill, all you need is an axe. Give it a go by clicking on one of the trees in the area."
#          after first talk:
#            u: next up you need to make a fire. First, you'll need to cut down a tree to get some logs.
#          after logs:
#            u11: "You managed to cut some logs."
#              u12: "Now that you have some logs, its time to light a fire. First, click on the tinderbox in your inventory. Then, with the tinderbox highlighted, click on the logs to use the tinderbox on them."
#            u: now that you have some shrimp, you're going to want to cook them. To do that, you'll need a fire.
#            after made fire:
#              u13: "now its time to get cooking. To do so, click on the shrimp in your inventory. Then, with the shrimp highlighted, click on a fire to cook them. If you look at the top left of the screen, you'll see the instructions that you're giving to your character."
#
#              u: now that you have some shrimp, you're going to want to cook them. All you ned to do is use them on a fire.
#              after cooked shrimp:
#                #$zap next
#                u14: "you managed to cook some shrimp"
#                u15: "well done, you've just cooked your first meal! speak to the survival expert if you want a recap, otherwise you can move on. Click on the gate shown and follow the path."
#          
#
#        script:
#          first::
#            p7: "I managed to catch some shrimp."
#            d8: "Excellent work. Now that you have some shrimp, you're going to want to cook them. To do that, you'll need a fire. that brings us on to the woodcutting and firemaking skills."
#            u9: "the survival expert gives you a bronze axe and a tinderbox."
#            u10: "It's time to cook your shrimp. However, you require a fire to do that which means you need some logs.  You can cut down trees using your woodcutting skill, all you need is an axe. Give it a go by clicking on one of the trees in the area."
#          after first talk:
#            u: next up you need to make a fire. First, you'll need to cut down a tree to get some logs.
#          after logs:
#            u11: "You managed to cut some logs."
#              u12: "Now that you have some logs, its time to light a fire. First, click on the tinderbox in your inventory. Then, with the tinderbox highlighted, click on the logs to use the tinderbox on them."
#            u: now that you have some shrimp, you're going to want to cook them. To do that, you'll need a fire.
#          after made fire:
#            u13: "now its time to get cooking. To do so, click on the shrimp in your inventory. Then, with the shrimp highlighted, click on a fire to cook them. If you look at the top left of the screen, you'll see the instructions that you're giving to your character."
#
#            u: now that you have some shrimp, you're going to want to cook them. All you ned to do is use them on a fire.
#          after cooked shrimp:
#            zap next
#            u14: "you managed to cook some shrimp"
#            u15: "well done, you've just cooked your first meal! speak to the survival expert if you want a recap, otherwise you can move on. Click on the gate shown and follow the path."
#    Finished:
#      click trigger:
#        script:
#        d16: "hello again. is there something you'd like to hear more about?"
#
#      chat trigger:
#        skills:
#          trigger: skills
#          script:
#            - tell me about my skills again
#            d17: every skill is listed in the skills menu. Here you can see what your current levels are and how much experience you have.
#            d18: as you move your mouse over the various skills the small yellow popup box will show you the exact amount of experience you have and how much is needed to get to the next level.
#            d19: you can also click on a skill to open up the relevant skillguide. In the skillguide, you can see all of the unlocks available in that skill.
#            d20: is there anything else you'd like to hear more about?
#        woodcutting:
#          trigger: woodcutting
#          script:
#            - tell me about woodcutting again
#                d21: woodcutitng, eh? Don't worry, newcomer, it's really very easy. Simply equip your axe and click on a nearby tree to chop away.
#                d22: as you explore the mainlands you will discover many different kinds of trees that will require different woodcutting levels to chop down.
#                d23: Logs are not only useful for making fires. Many archers use the skill known Fletching to craft their own bows and arrows from trees.
#        firemaking:
#          trigger: firemaking
#          script:
#            - tell me about firemaking again
#              d24: certainly, newcomer. When you have logs simply use your tinderbox on them. If successful, you will start a fire.
#              d25: you can also set fire to logs you find lying on the floor already, and some other trhings can also be set alight...
#              d26: A tinderbox is always a useful item to keep around!
#            - more options
#        fishing:
#          trigger: fishing
#          script:
#            - tell me about fishing again
#              d27: Ah, yes. Fishing! Fishing is undoubtedly one of the more popular hobbies here in Gielinor!
#              d28: whenever you see sparkling waters, you can be sure there's probably some good fishing to be had there!
#              d29: not only are fish absolutely delicious when cooked, they will also heal lost health.
#              d30: i would recommend everbody has a go at Fishing at least once in their lives!
#                d20
#        cooking:
#          trigger: cooking
#          script:
#            - tell me about cooking again
#              d31: yes, the most basic of survival techniques. Most simple foods can be used on a fire to cook them. If you're feeling a bit fancier, you can also use a range to cook the food instead.
#              d32: eating cooked food will restore lost health. The harder something is to cook, the more it will heal you.
#              d33: 
#            - nothing thanks
#            - previous options
#
#        remind until pass gate:
#        u34: follow the path until you get to the door with the yellow arrow above it. Click on the door to open it.

            
            







