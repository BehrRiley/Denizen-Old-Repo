# | ███████████████████████████████████████████████████████████
# % ██    Server Start | Stop Events
# | ██
# % ██  [ Discord Handlers ] ██
Discord_Bots:
  type: world
  debug: false
  speed: 0
  events:
# $ ███ [ Server Startup       ] ███
    on server start:
    - debug debug "# ███ [ Discord Connections start in: 15s ] ███"
    - wait 15s
    - yaml load:data/discord.yml id:DiscBot_temp
    - yaml load:data/memory.yml id:memory
    - yaml load:data/dmemory.yml id:dmemory
    - debug approval "Loading General Bot..."
    - ~discord id:GeneralBot connect code:<yaml[DiscBot_temp].read[bots.discord.GeneralBotToken]>
    - wait 5s
    - debug approval "Loading BehrBot..."
    - ~discord id:BehrBot connect code:<yaml[DiscBot_temp].read[bots.discord.GeneralBotToken]>
    - yaml unload id:DiscBot_temp
# $ ███ [ Server Shutdown      ] ███
    on shutdown:
      - discord id:GeneralBot disconnect
      - discord id:BehrBot disconnect

Relay_Chat_Task:
  type: task
  definitions: Channel|Message
  debug: false
  script:
    - define History <server.flag[Behrry.Essentials.ChatHistory.<[Channel]>]>
    - if <[History].size||0> > 30:
        - flag server Behrry.Essentials.ChatHistory.<[Channel]>:<-:<[History].reverse.last>
    - flag server Behrry.Essentials.ChatHistory.<[Channel]>:->:<[Message]>
    - announce <[Message].unescaped>
  
Chat_Channel_Load:
  type: task
  definitions: Channel
  debug: false
  script:
    - define History <server.flag[Behrry.Essentials.ChatHistory.Global]>
    - foreach <[History].reverse.get[1].to[25].reverse> as:Message:
      - narrate <[Message].unescaped>
    - narrate "<proc[Colorize].context[Channel Loaded: <[Channel]>|green]>"