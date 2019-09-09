# | ███████████████████████████████████████████████████████████
# % ██   /npc assignment --set Hans
# | ██
# % ██ [ Assignment Script ] ██
Hans:
  type: assignment
  debug: false
  actions:
    on assignment:
    - trigger name:click state:true
    - trigger name:proximity state:true radius:4
    - trigger name:chat state:true
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
        
      - narrate format:npc "Hello. What are you doing here?"
      - inject locally GenericGreeting Instantly
  GenericGreeting:
    - wait 2s
    - define Options_List "<list[I'm looking for whoever is in charge of this place.|I have come to kill everyone in this castle!|I don't know. I'm lost. Where am i?|Can you tell me how long I've been here?]>"
    #- define Trigger_List "<list[who|kill|where|how]>"
    - define Step Normal
    - if <script[<script.name>_interact].step[<player>]> != Normal:
      - zap Hans_Interact Normal duration:2m
    - Inject OptionCooldown Instantly
    - inject Trigger_Option_builder Instantly
  interact scripts:
    - Hans_Interact

# | ██  [ Hans Interact Script ] ██
Hans_Interact:
  type: interact
  debug: false
  speed: 0
  steps:
    Greeting*:
      chat trigger:
        Greeting:
          trigger: "/Hi|Hello|Howdy|hey"
          hide trigger message: true
          script:
            - zap Normal duration:2m
            - narrate format:player "<context.keyword>"
            - wait 2s
            - narrate format:npc "Hello. What are you doing here?"
            - inject <script.name.before[_interact]> path:GenericGreeting Instantly
    Normal:
      chat trigger:
        MiscChatter1:
          trigger: "/who|whoever/ is /incharge|charge|leader|duke|king|prince/ here /second|floor/"
          hide trigger message: true
          script:
            - if <player.flag[interacting_npc]||null> != <script.name.before[_interact]>:
              - stop
            - flag player option_cooldown.MiscChatter1 duration:15s
            - flag player interacting_npc:!
            - zap Greeting
            - narrate format:player "I'm looking for whoever is in charge of this place."
            - wait 2s
            - narrate format:npc "Who, the Duke? He's in the study, on the second floor."
        MiscChatter2:
          trigger: "/kill|everybody|murder|destroy/"
          hide trigger message: true
          script:
            - if <player.flag[interacting_npc]||null> != <script.name.before[_interact]>:
              - stop
            - flag player option_cooldown.MiscChatter2 duration:5m
            - flag player interacting_npc:!
            - zap Greeting
            - narrate format:player "I have come to kill everyone in this castle!"
            - wait 2s
            - narrate format:npc "Help! Help!"
        WhereAmI:
          trigger: "/where|location|what|place/"
          hide trigger message: true
          script:
            - if <player.flag[interacting_npc]||null> != <script.name.before[_interact]>:
              - stop
            - flag player option_cooldown.WhereAmI duration:15s
            - flag player interacting_npc:!
            - zap Greeting
            - narrate format:player "I don't know. I'm lost. Where am i?"
            - wait 2s
            - narrate format:npc "You are in Lumbridge Castle."
        Timestamp:
          trigger: "/how|long|been|time|duraton|playtime|play/"
          hide trigger message: true
          speed: 0
          script:
            - if <player.flag[interacting_npc]||null> != <script.name.before[_interact]>:
              - stop
            - flag player option_cooldown.Timestamp duration:15s
            - flag player interacting_npc:!
            - zap Greeting
            - narrate format:player "Can you tell me how long I've been here?"
            - wait 2s
            
            - define PDays "<&6><player.statistic[PLAY_ONE_MINUTE].div[1728000].round_down><&f><&o>"
            - define PHours "<&6><player.statistic[PLAY_ONE_MINUTE].div[72000].round_down.mod[24]><&f><&o>"
            - define PMinutes "<&6><player.statistic[PLAY_ONE_MINUTE].div[1200].round_down.mod[60]><&f><&o>"
            - define FirstDays "<&6><util.date.time.duration.sub[<player.first_played>].in_days.round_down><&f><&o>"

            - narrate format:npc "Ahh, i see all the newcomers arriving in Lumbridge, fresh-faced and eager for adventure. I remember you..."
            - wait 3s
            - narrate format:npc "You've spent <[PDays]> days, <[PHours]> hours, <[PMinutes]> minutes in the world since you arrived <[FirstDays]> days ago."
  Triggers:
    MiscChatter1: who
    MiscChatter2: kill
    WhereAmI: where
    TimeStamp: how
#days since last played:
#  <server.current_time_millis.div[86400000].sub[<player.last_played.in_milliseconds.div[86400000]>]>

#Time Played Days:
#  <player.statistic[PLAY_ONE_MINUTE].div_int[1728000].round_down>
#Time Played Hours:
#  <player.statistic[PLAY_ONE_MINUTE].div_int[72000].round_down.mod[24]>
#Time played Minutes:
#  <player.statistic[PLAY_ONE_MINUTE].div_int[1200].round_down.mod[60]>

#Better first Played:+
#days:
#  <util.date.time.duration.sub[<player.first_played>].in_days.round_down>

#total days ago:
#  <server.current_time_millis.sub[<player.first_played.in_seconds.mul[1000]>].div[1000].div[3600].div[24].round_down>
#total hour into that day:
#  <server.current_time_millis.sub[<player.first_played.in_seconds.mul[1000]>].div[1000].div[3600].round_down.mod[24]>
#total minutes into that day:
#  <server.current_time_millis.sub[<player.first_played.in_seconds.mul[1000]>].div[1000].div[60].round_down.mod[60]>
