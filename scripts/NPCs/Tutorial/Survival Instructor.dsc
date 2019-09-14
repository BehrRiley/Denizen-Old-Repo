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
      chat trigger:
        Greet:
          trigger: /Hi|Hello|Howdy|Hey/
          hide trigger message: true
          script:
            
            
            # ^ ██ [ Survival Expert ] ██
  d1: "Hello there, newcomer. My name is Brynna. My job is to teach you about the skills you can use to survive in this world."
  d2: "The first skill we're going to look at is Fishing. There's some shrimp in this pond here. Let's try and catch some."
  u3: "- gives you a small fishing yet -"
  u4: "to view the item you've been given, you'll need to open your inventory. To do so, click on the flashing backpack icon to the right hand side of your screen."
  u5: "This is your inventory. You can view all of your items here, including the net youve just beeen given. Lets use it to catch some shrimp. To start fishing, just click on the sparkling fishing spot, indicated by the flashing arrow."
  u6: "On this menu, you can view your skills. Your skills can be leveled up by earning experience, which is gained by performing various activities. As you level up your skills, you will earn new unlocks. Speak to the survival expert to continue."
  p7: "I managed to catch some shrimp."
  d8: "Excellent work. Now that you have some shrimp, you're going to want to cook them. To do that, you'll need a fire. that brings us on to the woodcutting and firemaking skills."
  u9: "the survival expert gives you a bronze axe and a tinderbox."
  u10: "It's time to cook your shrimp. However, you require a fire to do that which means you need some logs.  You can cut down trees using your woodcutting skill, all you need is an axe. Give it a go by clicking on one of the trees in the area."
  u11: "You managed to cut some logs."
  u12: "Now that you have some logs, its time to light a fire. First, click on the tinderbox in your inventory. Then, with the tinderbox highlighted, click on the logs to use the tinderbox on them."
  u13: "now its time to get cooking. To do so, click on the shrimp in your inventory. Then, with the shrimp highlighted, click on a fire to cook them. If you look at the top left of the screen, you'll see the instructions that you're giving to your character."
  u14: "you managed to cook some shrimp"
  u15: "well done, you've just cooked your first meal! speak to the survival expert if you want a recap, otherwise you can move on. Click on the gate shown and follow the path."
  d16: "hello again. is there something you'd like to hear more about?"