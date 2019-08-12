ThievingHandler:
  type: world
  debug: false
  events:
    on player right clicks entity:
      - if <context.entity.has_flag[Thieving.Table]> && <player.is_sneaking> && <player.location.points_between[<context.location>].distance[1].size> == 1:
        - animate <player> animation:arm_swing
        - inventory open d:in@PickpocketInterface
    on player clicks in PickpocketInterface:
      - determine passively cancelled
      - if <context.slot> == 5:
        - if <context.item.contains[Sunflower]>:
        #- if <context.item.contains[flint_and]>:
          - give money <context.item.nbt[loot]>
          - take slot:5 from:<context.inventory>
          - narrate "You take <context.item.nbt[loot]> Coins."
        - else:
          - give <context.item>
          - take slot:5 from:<context.inventory>
        - define xp "<context.item.nbt[xpref]>"
        - wait 5t
        - run add_xp def:<def[xp]>|Thieving instantly  
        - inventory close

# % ██ [ Personal Notes
# | ██ [ <npc.flag[Thieving.Table]> == Their Table to search for
# | ██ [ <script.yaml_key[]>  == searching PickpocketInterface script
# : ██ [ 
# | ██ [ "<s@ThievingRef.yaml_key[]>" == searching inside "loot table" yaml ##Quotations Required
# | ██ [ "<s@ThievingRef.yaml_key[Man]>" == 3
# | ██ [ "<s@ThievingRef.yaml_key[<npc.flag[Thieving.Table]>]> == 3"


PickpocketInterface:
    debug: true
    type: inventory
    inventory: dispenser
    title: Stolen Items
    procedural items:
      # item determine
      - if <util.random.int[1].to[2]> == 1 && <s@ThievingRef.yaml_key[<npc.flag[Thieving.Table]>.misc].split[,].size||0> >= 1:
        - if <s@ThievingRef.yaml_key[<npc.flag[Thieving.Table]>].after[misc=].split[,].size> == 1:
          - define loot <s@ThievingRef.yaml_key[<npc.flag[Thieving.Table]>.misc.1]>
        - else:
          - define lootct <s@ThievingRef.yaml_key[<npc.flag[Thieving.Table]>.misc].split[,].size>
          - define randct <util.random.int[1].to[<def[lootct]>]>
          - define loot <s@ThievingRef.yaml_key[<npc.flag[Thieving.Table]>.misc.<def[randct]>]>

      #Coin determine
      - else:
        - if <s@ThievingRef.yaml_key[<npc.flag[Thieving.Table]>.Coin].split[,].size> <= 1:
          - define backup <s@ThievingRef.yaml_key[<npc.flag[Thieving.Table]>.Coin]>
          - define Coin <s@ThievingRef.yaml_key[<npc.flag[Thieving.Table]>.Coin.1]||<def[backup]>>
        - else:
          - define lootct <s@ThievingRef.yaml_key[<npc.flag[Thieving.Table]>.Coin].split[,].size>
          - define randct <util.random.int[1].to[<def[lootct]>]>
          - define Coin <s@ThievingRef.yaml_key[<npc.flag[Thieving.Table]>.Coin.<def[randct]>]>
        - define xp <s@ThievingRef.yaml_key[<npc.flag[Thieving.Table]>.xp]>
        - define CoinInt li@1|2|3|4|5|25|100|250|1000|10000
        - foreach <def[CoinInt]>:
          - if <def[Coin]> >= <def[value]>:
            - define Cointex <s@ItemReference.yaml_key[Coins.<def[value]>]>
        
        #- define loop 0
        #- while <def[Cointex]> < <s@ItemReference.yaml_key[Coin.<def[loop]>]>:
        #  - define <def[]>
        #- define Cointex <s@ItemReference.yaml_key[]>

        - define loot "Sunflower[display_name=<&e><def[Coin]> Gold Coins!;flags=HIDE_UNBREAKABLE;durability=<def[Cointex]>;unbreakable=true;nbt=li@loot/<def[Coin]>|xpref/<def[xp]>]"
      - determine li@<def[loot]>
    slots:
      - "[blank] [blank] [blank]"
      - "[blank] [] [blank]"
      - "[blank] [blank] [blank]"



# % ██ [ Template                            ] ██ #
# | ██ [ npc type                            ] ██ #
# | ██ [  #xp:                               ] ██ #
# | ██ [  #Coin: (<Coin amount if only one>) ] ██ #
# | ██ [   #1: <Coin option 1 if multiple>   ] ██ #
# | ██ [   #2: <Coin option 2 if multiple>   ] ██ #
# | ██ [  #misc:                             ] ██ #
# | ██ [   #1: <Misc option 1 if multiple>   ] ██ #
# | ██ [   #2: <Misc option 2 if multiple>   ] ██ #

ThievingRef:
  type: yaml data
  debug: false
  man:
    xp: 8
    Coin: 3
  testman:
    xp: 8
    coin:
      1: 10
      2: 25
    misc:
      1: i@potato
      2: i@potato[quantity=2]
  farmer:
    xp: 14.5
    gold: 9
    misc:
      1: i@potato[quantity=1]
      2: i@potato[quantity=2]
  female ham:
    xp: 18.5
  male ham:
    xp: 22.5
  warrior: 
    xp: 26
    gold: 18
  rogue:
    xp: 35.5
    gold: 
      1: 25
      2: 26
  cave goblin:
    xp: 40
    gold: 30
  master farmer:
    xp: 43
    gold: 40
    misc: 
  guard:
    xp: 46.8
    gold: 30
  fremennik citizen:
    xp: 65
    gold: 40
  bearded pollnivnian bandit:
    xp: 65
    gold: 40
  desert bandit:
    xp: 79.5
    gold: 30
    misc: 
  knight:
    xp: 84.3
    gold: 50
  pollnivian bandit:
    xp: 84.3
    gold: 50
  yannile watchman:
    xp: 137.5
    gold: 60
    misc: 
      1: i@bread
  menaphite thug:
    xp: 137.5
    gold: 60
  paladin:
    xp: 151.75
    gold: 80
    misc: 
      1: i@chaos_rune[quantity=80]
  gnome:
    xp: 198.5
    gold: 300
    misc: 
  hero:
    xp: 275
    gold: 
      1: 200
      2: 300
    misc: 
  elf:
    xp: 353
    gold: 
      1: 280
      2: 350
    misc: 
  TzHaar-Hur:

ItemReference:
  type: yaml data
  debug: false
  Coins:
    1: 21
    2: 22
    3: 23
    4: 24
    5: 25
    25: 26
    100: 27
    250: 28
    1000: 29
    10000: 30
  runes:
    air: 1
    water: 2
    earth: 3
    fire: 4
    lava: 5
    mind: 6
    body: 7
    chaos: 8
    cosmic: 9
    blood: 10
    death: 11
    astral: 12
    law: 13
    nature: 14
    soul: 15
    mist: 16
    mud: 17
    smoke: 18
    steam: 19
    wrath: 20