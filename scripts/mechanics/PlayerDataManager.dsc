# | ███████████████████████████████████████████████████████████
# % ██    Player Data Management
# | ██
# % ██  [ Events ] ██
PlayerDataManager:
  type: world
  debug: false
  events:
    on player logs in:
      - if !<server.list_files[data/pData].contains[<player.uuid>]>:
        - yaml id:<player> create
        - yaml id:<player> savefile:data/pData/<player.uuid>.yml
      - else:
        - yaml id:<player> load:data/pData/<player.uuid>.yml