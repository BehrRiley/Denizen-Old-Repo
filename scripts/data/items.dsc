LastPageArrow:
  type: item
  debug: false
  material: tipped_arrow
  mechanisms: 
    potion_effects: 
      - INSTANT_HEAL,false,false
    flags: 
      - HIDE_POTION_EFFECTS
      - HIDE_ENCHANTS
      - HIDE_ATTRIBUTES
      - HIDE_UNBREAKABLE
      - HIDE_DESTROYS
      - HIDE_PLACED_ON
  display name: <&a>◀ <&2>L<&a>ast <&2>P<&a>age <&2>◀
  no-id: true
NextPageArrow:
  type: item
  debug: false
  material: tipped_arrow
  mechanisms: 
    potion_effects: 
      - INSTANT_HEAL,false,false
    flags: 
      - HIDE_POTION_EFFECTS
      - HIDE_ENCHANTS
      - HIDE_ATTRIBUTES
      - HIDE_UNBREAKABLE
      - HIDE_DESTROYS
      - HIDE_PLACED_ON
  display name: <&a>▶ <&2>N<&a>ext <&2>P<&a>age <&2>▶
  no-id: true

Blank:
  type: item
  debug: false
  material: black_stained_glass_pane
  display name: " "
  no-id: true

# : ████████████████████████████████████████████████████
# | ██   Main Spellbook & Misc
# : ██
# | ██ [ Main Spellbook ] ███
Spellbook_Item:
  type: item
  debug: false
  material: enchanted_book
  display name: "<&4>test item"
  enchantments: 
    - vanishing_curse:1 
  mechanisms: 
    flags: HIDE_ENCHANTS 
# | ██ [ Items | Sub-Spellbooks ] ██
BasicSpellbook_Item:
  type: item 
  debug: false
  material: enchanted_book
  display name: "<&4>B<&c>asic <&4>S<&c>pells"
  enchantments: 
    - vanishing_curse:1 
  mechanisms: 
    flags: HIDE_ENCHANTS 
  lore:
  - <&c>Level 1  <&f>|<&c>  Air Strike
  - <&c>Level 5  <&f>|<&c>  Water Strike
  - <&c>Level 9  <&f>|<&c>  Vex Strike<&4>*
  - <&c>Level 13 <&f>|<&c>  Fire Strike
IntermediateSpellbook_Item:
  type: item 
  debug: false
  material: enchanted_book
  display name: "<&4>I<&c>ntermediate <&4>S<&c>pells"
  enchantments: 
    - vanishing_curse:1 
  mechanisms: 
    flags: HIDE_ENCHANTS 
  lore:
  - <&c>Level 17 <&f>|<&c>  Air Bolt
  - <&c>Level 23 <&f>|<&c>  Water Bolt<&4>*
  - <&c>Level 29 <&f>|<&c>  Fratility<&4>*
  - <&c>Level 32 <&f>|<&c>  Leech
  - <&c>Level 35 <&f>|<&c>  Fire Bolt
AdvancedSpellbook_Item:
  type: item 
  debug: false
  material: enchanted_book
  display name: "<&4>A<&c>dvanced <&4>S<&c>pells"
  enchantments: 
    - vanishing_curse:1 
  mechanisms: 
    flags: HIDE_ENCHANTS 
  lore:
  - <&c>Level 39  <&f>|<&c>  Crumble Undead<&4>*
  - <&c>Level 41  <&f>|<&c>  Wind Blast
  - <&c>Level 47  <&f>|<&c>  Water Blast
  - <&c>Level 53  <&f>|<&c>  Decrepify
  - <&c>Level 55  <&f>|<&c>  Iban Blast<&4>*
  - <&c>Level 55  <&f>|<&c>  Magic Dart<&4>*
  - <&c>Level 59  <&f>|<&c>  Fire Blast
ExpertSpellbook_Item:
  type: item 
  debug: false
  material: enchanted_book
  display name: "<&4>E<&c>xpert <&4>S<&c>pells"
  enchantments: 
    - vanishing_curse:1 
  mechanisms: 
    flags: HIDE_ENCHANTS 
  lore:
  - <&c>Level 62  <&f>|<&c>  Wind Wave
  - <&c>Level 65  <&f>|<&c>  Water Wave
  - <&c>Level 70  <&f>|<&c>  Placeholder (vex...)<&4>*
  - <&c>Level 75  <&f>|<&c>  Fire Wave
MasterSpellbook_Item:
  type: item 
  debug: false
  material: enchanted_book
  display name: "<&4>M<&c>aster <&4>S<&c>pells"
  enchantments: 
    - vanishing_curse:1 
  mechanisms: 
    flags: HIDE_ENCHANTS 
  lore:
  - <&c>Level 81 <&f>|<&c>  Wind Surge
  - <&c>Level 85 <&f>|<&c>  Water Surge
  - <&c>Level 90 <&f>|<&c>  Placeholder (vex...)<&4>*
  - <&c>Level 95 <&f>|<&c>  Fire Surge
  
  
  #temp until depricate
BackArrow:
  type: item
  debug: false
  material: i@tipped_arrow[potion_effects=[potion_effects=li@INSTANT_HEAL,false,false;flags=li@HIDE_ENCHANTS|HIDE_ATTRIBUTES|HIDE_UNBREAKABLE|HIDE_DESTROYS|HIDE_PLACED_ON|HIDE_POTION_EFFECTS]
  display name: <&2>B<&a>ack
  no-id: true
# ███ [ Items ] ███
AirStrike:
  type: item 
  debug: false
  material: enchanted_book
  display name: "<&4>A<&c>ir <&4>S<&c>trike"
  lore:
  - <&c>Level Requirement<&co> <&4>1
  - <&f>Basic level Air Spell.
WaterStrike:
  type: item 
  debug: false
  material: enchanted_book
  display name: "<&4>W<&c>ater <&4>S<&c>trike"
  lore:
  - <&c>Level Requirement<&co> <&4>5
  - <&f>Basic level Water Spell.
VexStrike:
  type: item 
  debug: false
  material: enchanted_book
  display name: "<&4>V<&c>ex <&4>S<&c>trike"
  lore:
  - <&c>Level Requirement<&co> <&4>9
  - <&f>Basic level Vex Spell.
FireStrike:
  type: item 
  debug: false
  material: enchanted_book
  display name: "<&4>F<&c>ire <&4>S<&c>trike"
  lore:
  - <&c>Level Requirement<&co> <&4>13
  - <&f>Basic level Fire Spell.
  
AirBolt:
  type: item 
  debug: false
  material: enchanted_book
  display name: "<&4>A<&c>ir <&4>B<&c>olt"
  lore:
  - <&c>Level Requirement<&co> <&4>17
  - <&f>Intermediate level Air Spell.
WaterBolt:
  type: item 
  debug: false
  material: enchanted_book
  display name: "<&4>W<&c>ater <&4>B<&c>olt"
  lore:
  - <&c>Level Requirement<&co> <&4>23
  - <&f>Intermediate level Water Spell.
Fratility:
  type: item 
  debug: false
  material: enchanted_book
  display name: "<&4>F<&c>ratility"
  lore:
  - <&c>Level Requirement<&co> <&4>29
  - <&f>Intermediate level ? Spell.
Leech:
  type: item 
  debug: false
  material: enchanted_book
  display name: "<&4>L<&c>eech"
  lore:
  - <&c>Level Requirement<&co> <&4>32
  - <&f>Intermediate level ? Spell.
FireBolt:
  type: item 
  debug: false
  material: enchanted_book
  display name: "<&4>F<&c>ire <&4>B<&c>olt"
  lore:
  - <&c>Level Requirement<&co> <&4>35
  - <&f>Intermediate level Fire Spell.
  
CrumbleUndead:
  type: item 
  debug: false
  material: enchanted_book
  display name: "<&4>C<&c>rumble <&4>U<&c>ndead"
  lore:
  - <&c>Level Requirement<&co> <&4>39
  - <&f>Advanced level ? Spell.
WindBlast:
  type: item 
  debug: false
  material: enchanted_book
  display name: "<&4>W<&c>ind <&4>B<&c>last"
  lore:
  - <&c>Level Requirement<&co> <&4>41
  - <&f>Advanced level Wind Spell.
WaterBlast:
  type: item 
  debug: false
  material: enchanted_book
  display name: "<&4>W<&c>ater <&4>B<&c>last"
  lore:
  - <&c>Level Requirement<&co> <&4>47
  - <&f>Advanced level Water Spell.
Decrepify:
  type: item 
  debug: false
  material: enchanted_book
  display name: "<&4>D<&c>ecrepify"
  lore:
  - <&c>Level Requirement<&co> <&4>53
  - <&f>Advanced level ? Spell.
Ibanblast:
  type: item 
  debug: false
  material: enchanted_book
  display name: "<&4>I<&c>ban <&4>B<&c>last"
  lore:
  - <&c>Level Requirement<&co> <&4>55
  - <&f>Advanced level ? Spell.
MagicDart:
  type: item 
  debug: false
  material: enchanted_book
  display name: "<&4>M<&c>agic <&4>D<&c>art"
  lore:
  - <&c>Level Requirement<&co> <&4>55
  - <&f>Advanced level ? Spell.
FireBlast:
  type: item 
  debug: false
  material: enchanted_book
  display name: "<&4>F<&c>ire <&4>B<&c>last"
  lore:
  - <&c>Level Requirement<&co> <&4>59
  - <&f>Advanced level Fire Spell.
  
WindWave:
  type: item 
  debug: false
  material: enchanted_book
  display name: "<&4>W<&c>ind <&4>W<&c>ave"
  lore:
  - <&c>Level Requirement<&co> <&4>62
  - <&f>Expert level Wind Spell.
WaterWave:
  type: item 
  debug: false
  material: enchanted_book
  display name: "<&4>W<&c>ater <&4>W<&c>ave"
  lore:
  - <&c>Level Requirement<&co> <&4>65
  - <&f>Expert level Water Spell.
VexSomethingI:
  type: item 
  debug: false
  material: enchanted_book
  display name: "<&4>P<&c>laceholder"
  lore:
  - <&c>Level Requirement<&co> <&4>70
  - <&f>Expert level Vex Spell.
FireWave:
  type: item 
  debug: false
  material: enchanted_book
  display name: "<&4>F<&c>ire <&4>W<&c>ave"
  lore:
  - <&c>Level Requirement<&co> <&4>75
  - <&f>Expert level Fire Spell.
  
WindSurge:
  type: item 
  debug: false
  material: enchanted_book
  display name: "<&4>W<&c>ind <&4>S<&c>urge"
  lore:
  - <&c>Level Requirement<&co> <&4>81
  - <&f>Master level Wind Spell.
WaterSurge:
  type: item 
  debug: false
  material: enchanted_book
  display name: "<&4>W<&c>ater <&4>S<&c>urge"
  lore:
  - <&c>Level Requirement<&co> <&4>85
  - <&f>Master level Water Spell.
VexSomethingII:
  type: item 
  debug: false
  material: enchanted_book
  display name: "<&4>P<&c>laceholder"
  lore:
  - <&c>Level Requirement<&co> <&4>90
  - <&f>Master level Vex Spell.
FireSurge:
  type: item 
  debug: false
  material: enchanted_book
  display name: "<&4>F<&c>ire <&4>S<&c>urge"
  lore:
  - <&c>Level Requirement<&co> <&4>95
  - <&f>Master level Fire Spell.
