# | ███████████████████████████████████████████████████████████
# | ██    Open Bank Task
# % ██    - run open_bank (def:#) instantly
# % ██    - run open_bank_admin [def:#|player] instantly
# | ██
# % ██  [ Player Bank ] ██
Open_Bank:
  type: task
  debug: false
  definitions: BankID
  script:
    - define BankID <[BankID]||1>
    - define pBank <player.uuid>pBank_<[BankID]>
    - define slots1 <[BankID].sub[1].mul[45].add[1]>
    - define slots2 <[BankID].sub[1].mul[45].add[45]>
    - define title "Bank|Items <[slots1]>-<[slots2]>/450"
    - note "in@generic[title=<[title]>;size=54]" as:<[pBank]>
    - define items <yaml[pBankKey].read[<player.uuid>.<[BankID]>]||null>
    - if <[BankID]> > 1:
      - define LeftArrow i@LastPageArrow[nbt=BankID/<[BankID].sub[1]>]
    - else:
      - define LeftArrow i@blank
    - if <[bankID]> == 10:
      - define RightArrow i@blank
    - else:
      - define RightArrow i@NextPageArrow[nbt=BankID/<[BankID].add[1]>]
    - define SoftMenu "li@<[LeftArrow]>|i@Blank|i@Blank|i@Blank|i@Blank|i@Blank|i@Blank|i@Blank|<[RightArrow]>"
    #- foreach <[SoftMenu]>:
    #  - inventory add slot:<[loop_index].add[45]> d:in@<[pBank]> origin:<[value]>
    - define my_super_duper_lovey_item i@bankleftarrow
    - inventory set d:in@<[pBank]> o:<[SoftMenu]> slot:46
    - if <[items]> != null:
      - inventory set d:in@<[pBank]> o:<[items]>
    - inventory open d:in@<[pBank]>

# | ██  [ Admin Bank ] ██
Open_Bank_Admin:
  type: task
  debug: false
  definitions: BankID|Player
  UserVerification:
  - if <server.match_player[<[Player]>]||null> != "null":
    - define User <server.match_Player[<[Player]>]>
  - else if <server.match_player_offline[<[Player]>]||null> != "null":
    - define User <server.match_Player_offline[<[Player]>]>
  - else:
    - inject locally ErrorObjection instantly
  ErrorObjection:
    - define key "<&4>invalid character<&co><&nl><&c><[Player]||null>"
    - narrate format:bbf "Internal error <&pipe> <&c><proc[msgHover].context[<&c>Invalid Character|<[key]>]>"
    - stop
  script:
  - inject locally UserVerification instantly
  - define BankID <[BankID]||1>
  - define pBank <[User].uuid>pBank_<[BankID]>
  - define slots1 <[BankID].sub[1].mul[45].add[1]>
  - define slots2 <[BankID].sub[1].mul[45].add[45]>
  - define title "Bank<&pipe>Items <[slots1]>-<[slots2]>/450"
  - note "in@generic[title=<[title]>;size=54]" as:<[pBank]>
  - define items <yaml[pBankKey].read[<[User].uuid>.<[BankID]>]||null>
  - if <[BankID]> > 1:
    - define LeftArrow i@LastPageArrow[nbt=li@BankID/<[BankID].sub[1]>|PlayerID/<[Player]>]
  - else:
    - define LeftArrow i@blank
  - if <[bankID]> == 10:
    - define RightArrow i@blank
  - else:
    - define RightArrow i@NextPageArrow[nbt=li@BankID/<[BankID].add[1]>|PlayerID/<[Player]>]
  - define SoftMenu "li@<[LeftArrow]>|i@Blank|i@Blank|i@Blank|i@Blank|i@Blank|i@Blank|i@Blank|<[RightArrow]>"
  - inventory set d:in@<[pBank]> o:<[SoftMenu]> slot:46
  - if <[items]> != null:
    - inventory set d:in@<[pBank]> o:<[items]>
  - inventory open d:in@<[pBank]>

# | ███████████████████████████████████████████████████████████
# % ██    Bank Handlers
# | ██
# % ██  [ Events ] ██
PlayerBank_Handler:
  type: world
  debug: false
  Inventory_Load:
    - if <server.has_file[data/pBank/pBankKey.yml].not>:
      - yaml create "id:pBankKey"
      - yaml "savefile:data/pBank/pBankKey.yml" "id:pBankKey"
    - else:
      - yaml "load:data/pBank/pBankKey.yml" "id:pBankKey"
  Inventory_Save:
    - if <context.inventory.replace[<player.uuid>].starts_with[in@pBank].not||true>:
      - stop
    - define BankID <context.inventory.after[_]>
    - define dvlist <context.inventory.list_contents.get[1].to[45]>
    - yaml set id:pBankKey "<player.uuid>.<[BankID]>:<[dvlist]>"
    - yaml "savefile:data/pBank/pBankKey.yml" "id:pBankKey"
    - define id "<player.uuid>pBank_<[BankID]>"
    - note remove as:<[id]>
  events:
    on server start:
      - inject Locally Inventory_Load
    on reload scripts:
      - inject Locally Inventory_Load
    on player closes inventory:
      - inject Locally Inventory_Save
    on player clicks blank in inventory:
      - determine cancelled
    on player clicks LastPageArrow|NextPageArrow in inventory:
      - determine passively cancelled
      - inject locally Inventory_Save
      - run Open_Bank def:<context.item.nbt[bankid]> Instantly
