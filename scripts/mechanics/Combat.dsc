# : ████████████████████████████████████████████████████ 
# : ██   Depricating - reducing definitions & narrowing 
# : ██   process for damage targeting
# : ██ 
# | ██ [ Damage Proc ] ██
DamageProc:
  type: procedure
  debug: true
  definitions: EntityA|EntityB|Style|Spell
  script:
    # % ██ [ Melee ] ██
    - if <[style].contains_any[ENTITY_ATTACK|ENTITY_SWEEP_ATTACK]>:
      # - ██ Define Entity [A] {AttackLvl}||{StrengthLvl}||{AttackBonus}||{StrengthBonus}||{Max Hit} 
      - define Attack <[EntityA].flag[Attacklevel]||1>
      - define Strength <[EntityA].flag[Strengthlevel]||1>
      - define AttackBonus <[EntityA].flag[Attackbonus]||0>
      - define StrengthBonus <[EntityA].flag[Strengthbonus]||0>
      - define MaxHit <[Strength].add[3].mul[<[Strengthbonus].add[64]>].div[640].add[0.5].round_down>

      # - ██ Define Entity [A] {Attack Roll}||{Maximum Effective Level}||{Maximum Effective Base} 
      - define AttackRoll <[Attack].add[3].mul[<[Attackbonus].add[64]>]>
      - define MaxEffectiveLevelA <[Attackroll].sub[<element[11].mul[<[Attackbonus]>]>].sub[704].div[<[Attackbonus].add[64]>]>
      - define MaxEffectiveBonusA <[Attack].mul[-64].add[<[Attackroll]>].sub[704].div[<[Attack].add[11]>]>

      # - ██ Define Entity [B] {Defense Roll}||{Defense Bonus / Equipment Bonus}||{Defense Roll} 
      - define Defense <[EntityB].flag[DefenseLevel]||1>
      - define DefenseBonus <[EntityB].flag[DefenseBonus]||0>
      - define DefenseRoll <[Defense].mul[<[DefenseBonus].add[64]>]>

      # - ██ Define Entity [A] {Accuracy}||{Hit} 
      - define Accuracy <Tern[<[AttackRoll].is[MORE].than[<[DefenseRoll]>]>:]:<element[1].sub[<[DefenseRoll].add[2].div[<element[2].mul[<[AttackRoll].add[1]>]>]>]>||<[AttackRoll].div[<[DefenseRoll].add[1].mul[2]>]>>
      - define Hit <util.random.decimal.is[LESS].than[<[Accuracy]>]>

      # - ██ Define {Damage} 
      - define damage 0
      - define damage <[Damage].add[<tern[<[Hit]>]:<util.random.int[1].to[<[MaxHit]>]>||0>]>
      - determine <[Damage]>
      - queue clear

    # % ██ [Ranged ] ██
    - if <[style].contains_any[PROJECTILE]>:
      # - ██ Define Entity [A] {RangedLvl}||{RangedBonus}||{Max Hit} 
      - define Ranged <[EntityA].flag[Rangedlevel]||1>
      - define RangedBonus <[EntityA].flag[RangedBonus]||0>
      - define MaxHit <[Ranged].add[3].mul[<[RangedStrength].mul[<element[1].add[<[RangedStrength]>]>]>]||1>

      # - ██ Define Entity [A] {Attack Roll}||{Maximum Effective Level}||{Maximum Effective Base} 
      - define AttackRoll <[ranged].add[3].mul[<[rangedbonus].add[64]>]>
      - define MaxEffectiveLevelA <[Attackroll].sub[<element[11].mul[<[RangedBonus]>]>].sub[704].div[<[RangedBonus].add[64]>]>
      - define MaxEffectiveBonusA <[Ranged].mul[-64].add[<[Attackroll]>].sub[704].div[<[Ranged].add[11]>]>

      # - ██ Define Entity [B] {Defense Roll}||{Defense Bonus / Equipment Bonus}||{Defense Roll} 
      - define Defense <[EntityB].flag[DefenseLevel]||1>
      - define DefenseBonus <[EntityB].flag[DefenseBonus]||0>
      - define DefenseRoll <[Defense].mul[<[DefenseBonus].add[64]>]>

      # - ██ Define Entity [A] {Accuracy}||{Hit} 
      - define Accuracy <Tern[<[AttackRoll].is[MORE].than[<[DefenseRoll]>]>:]:<element[1].sub[<[DefenseRoll].add[2].div[<element[2].mul[<[AttackRoll].add[1]>]>]>]>||<[AttackRoll].div[<[DefenseRoll].add[1].mul[2]>]>>
      - define Hit <util.random.decimal.is[LESS].than[<[Accuracy]>]>

      # - ██ Define {Damage} 
      - define damage 0
      - define damage <[Damage].add[<tern[<[Hit]>]:<util.random.int[1].to[<[MaxHit]>]>||0>]>
      - determine <[Damage]>
      - queue clear

    # % ██ [Magic ] ██
    - if <[style].contains_any[MAGIC]> && <[Spell]> != Null:
      # - ██ Define Entity [A] {MagicLvl}||{MagicBonus}||{MagicStrength}||{Max Hit} 
      - define Magic <[EntityA].flag[MagicLevel]||1>
      - define MagicBonus <[EntityA].flag[MagicBonus]||0>
      - define MagicStrength <[EntityA].flag[MagicStrength]||0>
      - define MaxHit <script.yaml_key[Spell.<[Spell]>].mul[<element[1].add[<[MagicStrength]>]>]||1>

      # - ██ Define Entity [A] {Attack Roll}||{Maximum Effective Level}||{Maximum Effective Base} 
      - define AttackRoll <[Magic].add[3].mul[<[MagicBonus].add[64]>]>
      - define MaxEffectiveLevelA <[Attackroll].sub[<element[11].mul[<[MagicBonus]>]>].sub[704].div[<[MagicBonus].add[64]>]>
      - define MaxEffectiveBonusA <[Magic].mul[-64].add[<[Attackroll]>].sub[704].div[<[Magic].add[11]>]>

      # - ██ Define Entity [B] {MagicLvl}||{Defense Roll}||{Defense Bonus / Equipment Bonus}||{Defense Roll} 
      - define MagicB <[EntityB].flag[MagicLevel]||1>
      - define Defense <[EntityB].flag[DefenseLevel]||1>
      - define DefenseBonus <[EntityB].flag[DefenseBonus]||0>
      - define DefenseRoll <[MagicB].mul[0.3].add[<[Defense].mul[0.7]>].mul[<[DefenseBonus].add[64]>]>

      # - ██ Define Entity [A] {Accuracy}||{Hit} 
      - define Accuracy <Tern[<[AttackRoll].is[MORE].than[<[DefenseRoll]>]>]:<element[1].sub[<[DefenseRoll].add[2].div[<element[2].mul[<[AttackRoll].add[1]>]>]>]>||<[AttackRoll].div[<[DefenseRoll].add[1].mul[2]>]>>
      - define Hit <util.random.decimal.is[LESS].than[<[Accuracy]>]>

      # - ██ Define {Damage} 
      - define damage 0
      - define damage <[Damage].add[<tern[<[Hit]>]:<util.random.int[1].to[<[MaxHit]>]>||0>]>
      - determine <[Damage]>

    # % ██ [ Magic Spell Ref ] ██
  Spell:
    "Air Strike": 2
    "Water Strike": 4
    "Vex Strike": 6
    "Fire Strike": 8

    "Air Bolt": 9
    "Water Bolt": 10
    "Fraility": 11
    "Leech": 12
    "Fire Bolt": 12

    "Crumble undead": 15
    "Wind Blast": 13
    "Water Blast": 14
    "Decrepify": 15
    "Iban Blast": 25
    #"Magic Dart": 10-19
    "Fire Blast": 16

    "Wind Wave": 17
    "Water Wave": 18
    "vexsomething": 19
    "Fire Wave": 20

    "Wind Surge": 21
    "Water Surge": 22
    "vexsomething": 23
    "Fire Surge": 24
