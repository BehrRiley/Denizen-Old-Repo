# : ███ [  When a player is directly connected to event:                          ] ███
# | ███ [    - run add_xp def:<#>|<skill> instantly                               ] ███
# | ███ [   ex:run add_xp def:100|farming instantly                               ] ███
# : ███ [                                                                         ] ███
# : ███ [  When a player is NOT directly connected to the event:                  ] ███
# | ███ [    - run add_xp_nostring def:<#>|<skill>|<player> instantly             ] ███
# | ███ [   ex:run add_xp_nostring def:100|farming|<player[Behr_Riley]> instantly ] ███

# % ███ [ returns xp needed for next level                                        ] ███
xp_calc:
    type: procedure
    definitions: lvl
    script:
        - define pow_term <[lvl].div[7]>
        - define mul_term <element[300].mul[<element[2].power[<[pow_term]>]>]>
        - determine <[lvl].add[<[mul_term]>].div[4].round_down>

# % ███ [ Grants the provided amount of xp to a player                            ] ███
add_xp:
  type: task
  definitions: xp|skill
  script:
      - if !<player.has_flag[<[skill]>.ExpReq]>:
          - flag player <[skill]>.ExpReq:0
      - if !<player.has_flag[<[skill]>.Level]>:
          - flag player <[skill]>.Level:1
      - while <[xp]> > 0:
          - define xp_req <proc[xp_calc].context[<player.flag[<[skill]>.Level]>]>
          - define to_add <[xp_req].sub[<player.flag[<[skill]>.ExpReq]>]>
          - define xp <[xp].sub[<[to_add]>]>
          - if <[xp]> >= 0:
              - flag player <[skill]>.Level:++
              - flag player <[skill]>.ExpReq:0
              - narrate "Congratulations, you've just advanced a <&6><[skill]><&r> level. <&nl>Your <&6><[skill]><&r> level is now <&6><player.flag[<[skill]>.Level]><&f>."
          - else:
              - flag player <[skill]>.ExpReq:+:<[xp].add[<[to_add]>]>

# % ███ [ Grants the provided amount of xp to an unstrung player                  ] ███
add_xp_nostring:
  type: task
  definitions: xp|skill|player
  script:
      - if !<[player].has_flag[<[skill]>.ExpReq]>:
          - flag <[player]> <[skill]>.ExpReq:0
      - if !<[player].has_flag[<[skill]>.Level]>:
          - flag <[player]> <[skill]>.Level:1
      - while <[xp]> > 0:
          - define xp_req <proc[xp_calc].context[<[player].flag[<[skill]>.Level]>]>
          - define to_add <[xp_req].sub[<[player].flag[<[skill]>.ExpReq]>]>
          - define xp <[xp].sub[<[to_add]>]>
          - if <[xp]> >= 0:
              - flag <[player]> <[skill]>.Level:++
              - flag <[player]> <[skill]>.ExpReq:0
          - else:
              - flag <[player]> <[skill]>.ExpReq:+:<[xp].add[<[to_add]>]>
