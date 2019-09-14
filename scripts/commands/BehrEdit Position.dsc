# | ███████████████████████████████████████████████████████████
# % ██    //Pos1 Command for positioning with BehrEdit
# | ██
# % ██  [ Command ] ██
# $ ██  [ TO-DO   ] ██ | actually write the script | Eventually add Grief Prevention switch
Position1_Command:
  type: command
  name: /position1
  debug: true
  description: Manually sets position one for BehrEdit.
  aliases:
    - /pos1
    - pos1
  use: "<proc[colorize].context[//position1 (<&lt>X Y Z<&gt>)"
  # (Size:<&lt>#<&gt> (Direction:))|yellow]>"
  tab complete:
    - if <context.args.size||0> == 0:
      - determine <player.location.x.round_up>
    - else if <context.args.size> == 1 && !<context.raw_args.ends_with[<&sp>]>:
      - determine <player.location.x.round_up>
    - else if <context.args.size> == 1 && <context.raw_args.ends_with[<&sp>]>:
      - determine <player.location.y.round_up>
    - else if <context.args.size> == 2 && !<context.raw_args.ends_with[<&sp>]>:
      - determine <player.location.y.round_up>
    - else if <context.args.size> == 2 && <context.raw_args.ends_with[<&sp>]>:
      - determine <player.location.z.round_up>
    - else if <context.args.size> == 3 && !<context.raw_args.ends_with[<&sp>]>:
      - determine <player.location.z.round_up>
    - else if <context.args.size> == 3 && <context.raw_args.ends_with[<&sp>]>:
      - determine <list[size:|s:]>
    - else if <context.args.size> == 4 && !<context.raw_args.ends_with[<&sp>]> && !<context.args.last.contains_any[size:|s:]> && !<context.args.last.contains[:]>:
      - determine <list[size:|s:]>
    - else if <context.args.size> == 4 && <context.raw_args.ends_with[<&sp>]>:
      - determine <list[direction:|d:]>
    - else if <context.args.size> == 5 && !<context.raw_args.ends_with[<&sp>]> && !<context.args.last.contains_any[direction:|d:]> && !<context.args.last.contains[:]>:
      - determine <list[direction:|d:]>
    - else if <context.args.size> == 5 && !<context.raw_args.ends_with[<&sp>]> && <context.args.last.contains[:]>:
      - if <context.raw_args.ends_with[direction:]>:
        - determine <list[direction:north|direction:south|direction:east|direction:west|direction:up|direction:down]>
      - else if <context.raw_args.ends_with[d:]>:
        - determine <list[d:north|d:south|d:east|d:west|d:up|d:down]>
    - else if <context.args.size> == 5 && !<context.raw_args.ends_with[<&sp>]>:
      - if <context.raw_args.contains[direction:]>:
        - determine <list[direction:north|direction:south|direction:east|direction:west|direction:up|direction:down].filter[starts_with[<context.args.last>]]>
      - else if <context.raw_args.contains[d:]>:
        - determine <list[d:north|d:south|d:east|d:west|d:up|d:down].filter[starts_with[<context.args.last>]]>

  Error:
    - define Command "<queue.script.yaml_key[aliases].get[1]||<queue.script.yaml_key[Name]>>"
    - define Hover "<proc[Colorize].context[You typed:|red]><&r><&nl><&c>//Replace <context.raw_args><&nl><&2>C<&a>lick to <&2>I<&a>nsert<&nl><&6>Syntax<&co> <queue.script.yaml_key[Use].parsed>"
    - define Message "<proc[Colorize].context[<[Reason]>|red]>"
    - narrate <proc[MsgHint].context[<[Message]>|<[Command]>|<[Hover]>]>
    - stop
  script:
    - define Pos 1
    - inject BehrEdit_Position_Command_Task Instantly

Position2_Command:
  type: command
  name: /position2
  debug: true
  description: Manually sets position two for BehrEdit.
  aliases:
    - /pos2
    - pos2
  use: "<proc[colorize].context[//position2 (<&lt>X Y Z<&gt>)"
  # (Size:<&lt>#<&gt> (Direction:))|yellow]>"
  tab complete:
    - if <context.args.size||0> == 0:
      - determine <player.location.x.round_up>
    - else if <context.args.size> == 1 && !<context.raw_args.ends_with[<&sp>]>:
      - determine <player.location.x.round_up>
    - else if <context.args.size> == 1 && <context.raw_args.ends_with[<&sp>]>:
      - determine <player.location.y.round_up>
    - else if <context.args.size> == 2 && !<context.raw_args.ends_with[<&sp>]>:
      - determine <player.location.y.round_up>
    - else if <context.args.size> == 2 && <context.raw_args.ends_with[<&sp>]>:
      - determine <player.location.z.round_up>
    - else if <context.args.size> == 3 && !<context.raw_args.ends_with[<&sp>]>:
      - determine <player.location.z.round_up>
    - else if <context.args.size> == 3 && <context.raw_args.ends_with[<&sp>]>:
      - determine <list[size:|s:]>
    - else if <context.args.size> == 4 && !<context.raw_args.ends_with[<&sp>]> && !<context.args.last.contains_any[size:|s:]> && !<context.args.last.contains[:]>:
      - determine <list[size:|s:]>
    - else if <context.args.size> == 4 && <context.raw_args.ends_with[<&sp>]>:
      - determine <list[direction:|d:]>
    - else if <context.args.size> == 5 && !<context.raw_args.ends_with[<&sp>]> && !<context.args.last.contains_any[direction:|d:]> && !<context.args.last.contains[:]>:
      - determine <list[direction:|d:]>
    - else if <context.args.size> == 5 && !<context.raw_args.ends_with[<&sp>]> && <context.args.last.contains[:]>:
      - if <context.raw_args.ends_with[direction:]>:
        - determine <list[direction:north|direction:south|direction:east|direction:west|direction:up|direction:down]>
      - else if <context.raw_args.ends_with[d:]>:
        - determine <list[d:north|d:south|d:east|d:west|d:up|d:down]>
    - else if <context.args.size> == 5 && !<context.raw_args.ends_with[<&sp>]>:
      - if <context.raw_args.contains[direction:]>:
        - determine <list[direction:north|direction:south|direction:east|direction:west|direction:up|direction:down].filter[starts_with[<context.args.last>]]>
      - else if <context.raw_args.contains[d:]>:
        - determine <list[d:north|d:south|d:east|d:west|d:up|d:down].filter[starts_with[<context.args.last>]]>

  Error:
    - define Command "<queue.script.yaml_key[aliases].get[1]||<queue.script.yaml_key[Name]>>"
    - define Hover "<proc[Colorize].context[You typed:|red]><&r><&nl><&c>//Replace <context.raw_args><&nl><&2>C<&a>lick to <&2>I<&a>nsert<&nl><&6>Syntax<&co> <queue.script.yaml_key[Use].parsed>"
    - define Message "<proc[Colorize].context[<[Reason]>|red]>"
    - narrate <proc[MsgHint].context[<[Message]>|<[Command]>|<[Hover]>]>
    - stop
  script:
    - define Pos 2
    - inject BehrEdit_Position_Command_Task Instantly

BehrEdit_Position_Command_Task:
  type: task
  debug: true
  Reset:
    - flag player Behredit.Position:!
    - flag player BehrEdit.Selection.Cuboid:!
  script:
    - if <context.args.get[1]||null> == null:
      - define Loc <player.location.simple.as_location>
    - else:
      - if <context.args.get[1].is_int||false> && <context.args.get[2].is_int||false> && <context.args.get[3].is_int||false>:
      - define Loc <location[<context.args.get[1]>,<context.args.get[2]>,<context.args.get[3]>,<player.world.name>]>

    - if !<player.has_flag[Behredit.Selection.Mode]>:
      - narrate "<proc[Colorize].context[No Selection Mode Active|Red]> <&b>| <proc[Colorize].context[Bwand Mode entered: [Cuboid]|yellow]>"
      - flag player Behredit.Selection.Mode:Cuboid
    - if <player.flag[Behredit.Position.1].as_location.world.name||<player.world.name>> != <player.world.name> || <player.flag[Behredit.Position.2].as_location.world.name||<player.world.name>> != <player.world.name>:
      - inject locally Reset Instantly
      - narrate "<proc[Colorize].context[BehrEdit Positions Reset.|yellow]>"
    - define Type <list[left|right].get[<[Pos]>]>
    - run BehrEdit_Position_Task Instantly def:<list[left|right].get[<[Pos]>]>|<[Loc]>

    - choose <player.flag[BehrEdit.Selection.Mode]>:
      - case "Cuboid":
        - flag player Behredit.Position.<[Pos]>:<[Loc]>
        - define Pos1Flag <player.flag[Behredit.Position.1].as_location||<player.flag[Behredit.Position.2].as_location>>
        - define Pos2Flag <player.flag[Behredit.Position.2].as_location||<[Pos1Flag]>>
        - define cuboid <cuboid[<[Pos1Flag]>|<[Pos2Flag]>]>
        - define Size "<[Cuboid].blocks.size||0>"
        - if <[Size]||0> > 0:
          - define PosFormat "<&6>[<&6>X:<&e><player.location.cursor_on.x.round_down>, <&6>Y:<&e><player.location.cursor_on.y.round_down>, <&6>Z:<&e><player.location.cursor_on.z.round_down><&6>] [<&e>S<&e>ize<&6>:<&e> <[Size]><&6>]"
        - else:
          - define PosFormat "<&6>[<&6>X:<&e><player.location.cursor_on.x.round_down>, <&6>Y:<&e><player.location.cursor_on.y.round_down>, <&6>Z:<&e><player.location.cursor_on.z.round_down><&6>]"

        - flag player BehrEdit.Selection.Cuboid:<[Cuboid]>
        - if <player.has_flag[Behredit.Position.1]> && <player.has_flag[Behredit.Position.2]>:
          - playeffect effect:flame at:<[cuboid].shell> offset:0
          - playeffect effect:barrier at:<[cuboid].outline.parse[add[0.5,0.5,0.5]]> offset:0 visibility:250
        - narrate "<&6>P<&e>osition <&6>[<&e><[Pos]><&6>]<&e>: <[PosFormat]>"

      - case "ExpandingCuboid":
        - if <player.has_flag[Behredit.Position.ExpandingCuboid]>:
          - flag player Behredit.Position.ExpandingCuboid:<player.flag[Behredit.Position.ExpandingCuboid].as_cuboid.include[<[loc]>]>
        - else:
          - flag player Behredit.Position.ExpandingCuboid:<cuboid[<[loc]>|<[loc]>]>
    
        - define Size "<cuboid[<player.flag[Behredit.Position.ExpandingCuboid].as_cuboid>].blocks.size||0>"
        - define volume "<player.flag[Behredit.Position.ExpandingCuboid].as_cuboid.volume||0>"
        - if <[Size]||0> > 0:
          - define PosFormat "<&6>[<&6>X:<&e><player.location.cursor_on.x.round_down>, <&6>Y:<&e><player.location.cursor_on.y.round_down>, <&6>Z:<&e><player.location.cursor_on.z.round_down><&6>] [<&e>S<&e>ize<&6>:<&e> <[Size]><&6>] [<&e>V<&e>olume<&6>:<&e> <[Volume]><&6>]"
        - else:
          - define PosFormat "<&6>[<&6>X:<&e><player.location.cursor_on.x.round_down>, <&6>Y:<&e><player.location.cursor_on.y.round_down>, <&6>Z:<&e><player.location.cursor_on.z.round_down><&6>]"

        - flag player BehrEdit.Selection.Cuboid:<cuboid[<[loc]>|<[loc]>]>

        - define cuboid <player.flag[Behredit.Position.ExpandingCuboid]>
        - if <player.flag[Behredit.Position.ExpandingCuboid].as_cuboid.blocks.size||0> < 100000:
          - playeffect effect:flame at:<[cuboid].shell> offset:0 targets:<player>
        - playeffect effect:barrier at:<[cuboid].outline> offset:0 targets:<player>
        - narrate "<&6>P<&e>osition: <[PosFormat]>"
      - case "IrregularPolygon":
        # @ ██ [ Irregular Polygon ] ██
        - if !<player.has_flag[Behredit.Position.IrregularPoly]>:
          - flag player Behredit.Position.IrregularPolyPos:1
        - else:
          - flag player Behredit.Position.IrregularPolyPos:++
        - flag player Behredit.Position.IrregularPoly:->:<[loc]>

        - flag player BehrEdit.Selection.Cuboid:<cuboid[<player.flag[Behredit.Position.IrregularPoly]>]||0>

        - define Size "<cuboid[<player.flag[Behredit.Position.IrregularPoly]>].blocks.deduplicate.size||0>"
        - define volume "<cuboid[<player.flag[Behredit.Position.IrregularPoly]>].volume||0>"
        - if <[Size]||0> > 0:
          - define PosFormat "<&6>[<&6>X:<&e><player.location.cursor_on.x.round_down>, <&6>Y:<&e><player.location.cursor_on.y.round_down>, <&6>Z:<&e><player.location.cursor_on.z.round_down><&6>] [<&e>S<&e>ize<&6>:<&e> <[Size]><&6>] [<&e>V<&e>olume<&6>:<&e> <[Volume]><&6>]"
        - else:
          - define PosFormat "<&6>[<&6>X:<&e><player.location.cursor_on.x.round_down>, <&6>Y:<&e><player.location.cursor_on.y.round_down>, <&6>Z:<&e><player.location.cursor_on.z.round_down><&6>]"
        - if !<player.has_flag[Behredit.Monitor]>:
          - define cuboid <cuboid[<player.flag[Behredit.Position.IrregularPoly]>]>
          - if <[cuboid].blocks.size> < 100000:
            - playeffect effect:flame at:<[cuboid].shell> offset:0 targets:<player>
          - if <[cuboid].blocks.size> < 10000000:
            - playeffect effect:barrier at:<[cuboid].outline> offset:0 targets:<player>
              
        - narrate "<&6>P<&e>osition <&6>[<&e><player.flag[Behredit.Position.IrregularPoly].as_list.size><&6>]<&e>: <[PosFormat]>"
        # @ ██ [ ///////////////// ] ██
      - case "Filler":
        # @ ██ [ Filler ] ██
        - if <context.click_type.contains_any[left]>:
          - run BehrEdit_Position_Task Instantly
        - else:
          - if <player.item_in_offhand.contains[air]>:
            - narrate "<proc[Colorize].context[Missing Material:|red]> <&e>Offhand"
            - stop
          - else:
            - if !<player.has_flag[BehrEdit.Position.1]>:
              - narrate "<proc[Colorize].context[Missing First Position|red]>"
              - stop
            - if <player.has_flag[BehrEdit.SelectionQueue1]>:
              #- queue <player.flag[BehrEdit.SelectionQueue1]> clear
            - define Cuboid <cuboid[<player.flag[BehrEdit.Position.1]>|<[Loc]>]>
            - flag player BehrEdit.Undo.1L:<[Cuboid].blocks>
            - flag player BehrEdit.Undo.1M:<[Cuboid].blocks.parse[material]>
            - ~modifyblock <[Cuboid]> <player.item_in_offhand.material>
        # @ ██ [ ////// ] ██