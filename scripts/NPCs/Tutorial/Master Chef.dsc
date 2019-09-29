# | ███████████████████████████████████████████████████████████
# % ██   /npc assignment --set Master Chef
# | ██
# % ██ [ Assignment Script ] ██
Master Chef:
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
    - inject "Master Chef_Interact" "path:steps.greeting.chat trigger.script" Instantly
  interact scripts:
  - "Master Chef_Interact"

# | ██  [ Master Chef Interact Script ] ██
Master Chef_Interact:
  type: interact
  debug: false
  steps:
  #$ once enter:
  #$u Talk to chef indicated. He will teach you the more advanced aspects of Cooking such as combining ingredients.
    Greeting*:
      click trigger:
        script:
          - narrate "Ah! Welcome, newcomer. I am the Master Chef, Lev. It is here that I will teach you how to cook food truly fit for a king."
          - narrate "I already know how to cook. Brynna taught me just now."
          - narrate "Hahahahahaha! You call THAT cooking? Some shrimp on an open log fire? Oh, no, no, no. I am going to teach you the fine art of cooking bread."
          - narrate "The master chef gives you some flour and a bucket of water."
          - zap next
    make bread:
      click trigger:
        script:
          - narrate "Time for you to learn the fine art of cooking bread."
#                #$remind u6: This is the base for many meals. To make dough, you must mix flour with water. To do so, click on the flour in your inventory. Then, with the flour highlighted, click on the water to combine them into dough.
#                after make dough:
#                    u6: you make some dough.
#                    u7: Now you have made the dough, you can bake it into some bread. To do so, just click on the indicated range.
#                after making the bread:
#                    u8: you manage to make some bread.
#                    u9: Well done! You've baked your first loaf of bread. As you gain experience in cooking, you will be able to make other things like pies and cakes. You can now use the next doors to move on. If you need a recap on anything, talk to the master chef.
#                    d10: Do you need something?
#                    - tell me about making dough again
#                      d11: it's quite simple. JKust use a pot of flour on a bucket of water, or vice versa, and you'll make dough. you can fill a bucket with water at any sink.
#                      d12: Do you need anything else?
#                    - tell me about range cooking again
#                      d13: the range is the only place you can cook a lot of the more complex foods in Gielinor. To cook on a range, all you need to do is click on it. You'll need to make sure you have the required items in your inventory though.
#                      d12:













        