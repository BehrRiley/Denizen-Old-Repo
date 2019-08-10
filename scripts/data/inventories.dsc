# : ████████████████████████████████████████████████████
# | ██   Main Spellbook | Normal Spellbook
# : ██
# | ██ [ Main Inventory ] ███
Spellbook_Inventory:
  type: inventory
  debug: false
  inventory: dispenser
  title: Spellbook
  procedural items:
#    - define BasicLore li@
#    - define key BasicSpellbook
#    - foreach <script.list_keys[<[key]>].numerical>:
#      - define LoreColor <tern[<player.flag[MagicLevel].is[MORE].than[<[value]>]>]:<&a>||<&c>>
#      - define BasicLore <[BasicLore].include[<parse:<script.yaml_key[<[key]>.<[value]>]>>]>
#    - define Basic i@BasicSpellbook_Item[Lore=<[BasicLore]>]
    - define SpellBooks "li@BasicSpellbook_Item|IntermediateSpellbook_Item|AdvancedSpellbook_Item|ExpertSpellbook_Item|MasterSpellbook_Item"
    - define SpellbooksIndex li@
    - foreach <[SpellBooks]>:
      - define LoopIndexLore li@
      - define key <[value].before[_item]>
      - define LoopIndexBook <[value]>
      - define DisplayColor0 "<tern[<player.flag[MagicLevel].is[MORE].than[<script.yaml_key[BookRequirements.<[key].before[Spellbook]>]>]>]:<&a>||<&c>>"
      - define DisplayColor1 "<tern[<player.flag[MagicLevel].is[MORE].than[<script.yaml_key[BookRequirements.<[key].before[Spellbook]>]>]>]:<&2>||<&4>>"
      - define Display "<[DisplayColor1]><[value].char_at[1]><[DisplayColor0]><[value].substring[2].before[Spellbook]><&sp><[DisplayColor1]>S<[DisplayColor0]>pellbook"
      - foreach <script.list_keys[<[key]>].numerical>:
        - define LoreColor <tern[<player.flag[MagicLevel].is[MORE].than[<[value]>]>]:<&a>||<&c>>
        - define LoopIndexLore <[LoopIndexLore].include[<parse:<script.yaml_key[<[key]>.<[value]>]>>]>
      - define SpellbooksIndex "<[SpellbooksIndex].include[<[LoopIndexBook]>[lore=<[LoopIndexLore]>;Display_Name=<[Display]>]]>"
    - determine <[SpellbooksIndex]>
  slots:
  - "[] [i@blank] [i@blank]"
  - "[] [] [i@blank]"
  - "[] [] [i@blank]"
  BookRequirements:
    Basic: 0
    Intermediate: 16
    Advanced: 38
    Expert: 61
    Master: 80
  BasicSpellbook:
    0: "<[LoreColor]> Level  1 <&f>&pipe<[LoreColor]>  Air Strike"
    4: "<[LoreColor]> Level  5 <&f>&pipe<[LoreColor]>  Water Strike"
    8: "<[LoreColor]> Level  9 <&f>&pipe<[LoreColor]>  Vex Strike"
    12: "<[LoreColor]> Level 13 <&f>&pipe<[LoreColor]>  Fire Strike"
  IntermediateSpellbook:
    16: "<[LoreColor]> Level 17 <&f>&pipe<[LoreColor]> Air Bolt"
    22: "<[LoreColor]> Level 23 <&f>&pipe<[LoreColor]> Water Strike"
    28: "<[LoreColor]> Level 29 <&f>&pipe<[LoreColor]> Snare"
    31: "<[LoreColor]> Level 32 <&f>&pipe<[LoreColor]> Enfeeble"
    34: "<[LoreColor]> Level 35 <&f>&pipe<[LoreColor]> Fire Bolt"
  AdvancedSpellbook:
    38: "<[LoreColor]> Level 39 <&f>&pipe<[LoreColor]> Crumble Undead"
    40: "<[LoreColor]> Level 41 <&f>&pipe<[LoreColor]> Wind Blast"
    46: "<[LoreColor]> Level 47 <&f>&pipe<[LoreColor]> Water Blast"
    52: "<[LoreColor]> Level 53 <&f>&pipe<[LoreColor]> Leech"
    54: "<[LoreColor]> Level 55 <&f>&pipe<[LoreColor]> Iban Blast"
    54: "<[LoreColor]> Level 55 <&f>&pipe<[LoreColor]> Magic Dart"
    58: "<[LoreColor]> Level 59 <&f>&pipe<[LoreColor]> Fire Blast"
  ExpertSpellbook:
    61: "<[LoreColor]> Level 62 <&f>&pipe<[LoreColor]> Wind Wave"
    64: "<[LoreColor]> Level 65 <&f>&pipe<[LoreColor]> Water Wave"
    69: "<[LoreColor]> Level 70 <&f>&pipe<[LoreColor]> Fraility"
    74: "<[LoreColor]> Level 75 <&f>&pipe<[LoreColor]> Fire Wave"
  MasterSpellbook:
    80: "<[LoreColor]> Level 80 <&f>&pipe<[LoreColor]> Wind Surge"
    84: "<[LoreColor]> Level 85 <&f>&pipe<[LoreColor]> Water Surge"
    89: "<[LoreColor]> Level 90 <&f>&pipe<[LoreColor]> Decrepify"
    94: "<[LoreColor]> Level 95 <&f>&pipe<[LoreColor]> Fire Surge"

# : ████████████████████████████████████████████████████
# | ██   Spellbook Handlers
# : ██
# | ██ [ Spellbook Specific ] ██
SpellbookHandler:
  type: world
  debug: false
  events:
    # | ███ [ Misc Items ] ███
    on player clicks blank in Inventory:
      - determine cancelled
    on player clicks BackArrow in Inventory:
      - inventory open d:in@Spellbook_Inventory
      - determine cancelled

    # | ███ [ Spellbook Main Inventory ] ███
    on player clicks with Spellbook_Item:
      - inventory open d:in@Spellbook_Inventory
    on player clicks in Spellbook_Inventory:
      - define Spellbooks "li@BasicSpellbook_Item|IntermediateSpellbook_Item|AdvancedSpellbook_Item|ExpertSpellbook_Item|MasterSpellbook_Item"
      - if <context.item.contains_any[<[Spellbooks]>]>:
          - inventory open d:in@<context.item.after[;script=].before[_item]>_Inventory
          - determine passively cancelled
          
# temp until depricate
BasicSpellbook_Inventory:
  type: inventory
  debug: false
  inventory: dispenser
  title: Spellbook | Basic Spells
  size: 9
  slots:
  - "[i@AirStrike] [i@WaterStrike] [i@VexStrike]"
  - "[i@FireStrike] [i@blank] [i@blank]"
  - "[i@blank] [i@blank] [i@BackArrow]"
IntermediateSpellbook_Inventory:
  type: inventory
  debug: false
  inventory: dispenser
  title: Spellbook | Intermediate Spells
  size: 9
  slots:
  - "[i@AirBolt] [i@WaterBolt] [i@Fratility]"
  - "[i@Leech] [i@FireBolt] [i@blank]"
  - "[i@blank] [i@blank] [i@BackArrow]"
AdvancedSpellbook_Inventory:
  type: inventory
  debug: false
  inventory: dispenser
  title: Spellbook | Advanced Spells
  size: 9
  slots:
  - "[i@CrumbleUndead] [i@WindBlast] [i@WaterBlast]"
  - "[i@Decrepify] [i@Ibanblast] [i@MagicDart]"
  - "[i@FireBlast] [i@blank] [i@BackArrow]"
ExpertSpellbook_Inventory:
  type: inventory
  debug: false
  inventory: dispenser
  title: Spellbook | Expert Spells
  slots:
  - "[i@WindWave] [i@WaterWave] [i@VexSomethingI]"
  - "[i@FireWave] [i@blank] [i@blank]"
  - "[i@blank] [i@blank] [i@BackArrow]"
MasterSpellbook_Inventory:
  type: inventory
  debug: false
  inventory: dispenser
  title: Spellbook | Master Spells
  slots:
  - "[i@WindSurge] [i@WaterSurge] [i@VexSomethingII]"
  - "[i@FireSurge] [i@blank] [i@blank]"
  - "[i@blank] [i@blank] [i@BackArrow]"
