BwandMenu:
  type: inventory
  inventory: Dispenser
  debug: false
  title: "<&2>B<&a>ehr<&2>E<&a>dit <&2>M<&a>enu"
  procedural items:
    - define list li@
    - define item1 "i@player_head[nbt=li@key/mode cuboid;display_name=<&6>M<&e>ode<&6><&co> <&2>C<&a>uboid;skull_skin=09201882-f3e9-4267-aedb-f9a1e039009e|eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvZDliMzAzMDNmOTRlN2M3ODVhMzFlNTcyN2E5MzgxNTM1ZGFmNDc1MzQ0OWVhNDFkYjc0NmUxMjM0ZTlkZDJiNSJ9fX0=]"
    - define item2 "i@player_head[nbt=li@key/mode ExpandingCuboid;display_name=<&6>M<&e>ode<&6><&co> <&2>E<&a>xpanding <&2>C<&a>uboid;skull_skin=9000dd5d-fe9a-40f9-8724-5f9165616929|eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvZTNjYTdkN2MxNTM0ZGM2YjllZDE2NDdmOTAyNWRkZjI0NGUwMTA3ZGM4ZGQ0ZjRmMDg1MmM4MjA4MWQ2MzUwZSJ9fX0=]"
    - define item3 "i@player_head[nbt=li@key/mode IrregularPolygon;display_name=<&6>M<&e>ode<&6><&co> <&2>I<&a>rregular <&2>P<&a>olygon;skull_skin=29845bee-1871-46e3-9032-570e97ccf47e|eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvMTk1ZTFlMmZiMmRlN2U2Mjk5YTBmNjFkZGY3ZDlhNmQxMDFmOGQ2NjRmMTk1OWQzYjY3ZGNlOGIwNDlhOGFlMSJ9fX0=]"

    - define item4 "i@player_head[nbt=li@key/selection clear;display_name=<&4>C<&c>lear <&4>C<&c>lipboard;skull_skin=5c36282e-4536-4f10-8e66-a2f24b57ecad|eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvYjJlNTk0ZWExNTQ4NmViMTkyNjFmMjExMWU5NTgzN2FkNmU5YTZiMWQ1NDljNzBlY2ZlN2Y4M2U0MTM2MmI1NyJ9fX0=]"
    - define item5 "i@player_head[nbt=li@key/monitor;display_name=<&2>D<&a>isplay <&2>S<&a>election;skull_skin=eb3d9984-b0d2-4377-8e1d-0bfd04045ccc|eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvNGU1ODVmNjQzNGRiYTczMTMyYzRiMzg0OWJiMzc3ZjRhYjVjMDEzMzA3NjNhOGViOTQxN2I2ZTJkMDRmOWMzMiJ9fX0=]"
    - define item6 "i@player_head[display_name=<&2>D<&a>elete <&2>L<&a>ast;skull_skin=4d37c12c-eb19-4499-8c62-33d84c4d9761|eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvNTVkNWM3NWY2Njc1ZWRjMjkyZWEzNzg0NjA3Nzk3MGQyMjZmYmQ1MjRlN2ZkNjgwOGYzYTQ3ODFhNTQ5YjA4YyJ9fX0=]"

    - define item7 "i@player_head[nbt=li@key/selection clipboard;display_name=<&2>S<&a>election <&2>t<&a>ag]>;skull_skin=0bf42e07-8ca6-49a0-8de3-8762f9d169a5|eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvOWJlNzIwMzlhNDBmMTAwMmZiYTZhYjFiYjVmN2YwMGQ3MGY1M2I0YjQ4YzJlOWJmMGYxYmVhNzA4MzAwODFhYyJ9fX0=]"
    - define item8 "i@player_head[nbt=li@key/mode filler;display_name=<&6>M<&e>ode<&6><&co> <&2>F<&a>iller;skull_skin=710b5eec-602d-49ed-b73b-9f10bb57c579|eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvNjBhM2FmMTg3YmI4YjgzZTVhZjU2NmZiNmFmZGNmZjMzZTM2NDc2ZmIzNGIxOTA5NmYyYjU3ZDMzMTJmZTI5MiJ9fX0=]"

    - define list <list[<[item1]>|<[item2]>|<[item3]>|<[item4]>|<[item5]>|<[item6]>|<[item7]>|<[item8]>]>
   #- define "item<[Loop_index]>" "<[item<[Loop_index]>]>[nbt=li@key/<[Value]>]"
   #- define list <[list].include[<[item<[Loop_index]>]>]>
    - determine <[list]>
  slots:
    - "[] [] []"
    - "[] [] []"
    - "[] [] []"

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
