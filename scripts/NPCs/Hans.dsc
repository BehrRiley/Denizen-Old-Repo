# | ███████████████████████████████████████████████████████████
# % ██   /npc assignment --set Hans
# | ██
# % ██ [ Assignment Script ] ██
Hans:
  type: assignment
  debug: true
  actions:
    on assignment:
    - trigger name:click state:true
    - trigger name:proximity state:true radius:4
    - adjust <npc> skin_blob:<server.flag[npc.skin.<script.name>]>
    on exit proximity:
      - if <player.flag[interacting_npc]> == <script.name>:
        - flag player interacting_npc:!
    on click:
      - if <player.flag[interacting_npc]> == <script.name>:
        - flag player interacting_npc:<script.name>
        
      - narrate format:npc "Hello. What are you doing here?"
      - inject locally GenericGreeting Instantly
  GenericGreeting:
    - wait 2s
    - define Options_List "<list[I'm looking for whoever is in charge of this place.|I have come to kill everyone in this castle!|I don't know. I'm lost. Where am i?|Can you tell me how long I've been here?]>"
    - define Trigger_List "<list[who|kill|where|how]>"
    - inject Trigger_Option_builder Instantly
  interact scripts:
    - Hans_Interact

# | ██  [ Hans Interact Script ] ██
Hans_Interact:
  type: interact
  debug: false
  steps:
    Normal:
      chat trigger:
        MiscChatter1:
          trigger: "/who|charge|leader|duke|king|prince|floor/"
          hide trigger message: true
          script:
            - narrate format:npc "Who, the Duke? He's in the study, on the second floor."
            - flag player interacting_npc:!
        MiscChatter2:
          trigger: "/kill|everybody|murder|destroy/"
          hide trigger message: true
          script:
            - narrate format:npc "Help! Help!"
            - flag player interacting_npc:!
        WhereAmI:
          trigger: "/where|location|what|place/"
          hide trigger message: true
          script:
            - narrate format:npc "You are in Lumbridge Castle."
            - flag player interacting_npc:!
        Timestamp:
          trigger: "/how|long|been|time|duraton|playtime|play/"
          hide trigger message: true
          script:
            - define PDays "<&6><player.statistic[PLAY_ONE_MINUTE].div_int[1728000].round_down><&f>"
            - define PHours "<&6><player.statistic[PLAY_ONE_MINUTE].div_int[72000].round_down.mod[24]><&f>"
            - define PMinutes "<&6><player.statistic[PLAY_ONE_MINUTE].div_int[1200].round_down.mod[60]><&f>"
            - define FirstDays "<&6><util.date.time.duration.sub[<player.first_played>].in_days.round_down><&f>"

            - narrate format:npc "Ahh, i see all the newcomers arriving in Lumbridge, fresh-faced and eager for adventure. I remember you..."
            - wait 2s

            - narrate format:npc "You've spent <[PDays]> days, <[PHours]> hours, <[PMinutes]> minutes in the world since you arrived <[FirstDays]> days ago."
            - flag player interacting_npc:!

#days since last played:
#  <server.current_time_millis.div[86400000].sub[<player.last_played.in_milliseconds.div[86400000]>]>

#Time Played Days:
#  <player.statistic[PLAY_ONE_MINUTE].div_int[1728000].round_down>
#Time Played Hours:
#  <player.statistic[PLAY_ONE_MINUTE].div_int[72000].round_down.mod[24]>
#Time played Minutes:
#  <player.statistic[PLAY_ONE_MINUTE].div_int[1200].round_down.mod[60]>

#Better first Played:
#days:
#  <util.date.time.duration.sub[<player.first_played>].in_days.round_down>

#total days ago:
#  <server.current_time_millis.sub[<player.first_played.in_seconds.mul[1000]>].div[1000].div[3600].div[24].round_down>
#total hour into that day:
#  <server.current_time_millis.sub[<player.first_played.in_seconds.mul[1000]>].div[1000].div[3600].round_down.mod[24]>
#total minutes into that day:
#  <server.current_time_millis.sub[<player.first_played.in_seconds.mul[1000]>].div[1000].div[60].round_down.mod[60]>

#formatted days since last logged in
#<duration[<player.last_played.milliseconds.-[<server.current_time_millis>].abs./[1000]>].formatted>
