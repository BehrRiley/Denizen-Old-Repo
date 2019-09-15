# | ███████████████████████████████████████████████████████████
# % ██    //stackdist - used to stack blocks a number of blocks in
# % ██    a specific coordinated direction
# | ██
# % ██    //stackdist 10 | Copies and stacks the clipboard 10 blocks further
# | ██
# % ██  [ Command ] ██
# $ ██  [ TO-DO   ] ██ | add feature for multi-directional - ie, //stackdist iron_block 5 north 5 up 5 east
Stack_Command:
  type: command
  name: /stackdist
  debug: false
  description: Stacks selection a direction, optionally only by material(s)
  use: "<proc[colorize].context[//stack <&lt>#<&gt> (Direction) (Material{NotAir}) |yellow]>"
  tab complete:
    - if <context.args.size||0> == 0:
      - stop
    - else if <context.args.size> == 1 && !<context.raw_args.ends_with[<&sp>]>:
      - stop

    - define BlackList <list[Grass|Bedrock]>
    - define Directions <list[north|south|east|west|up|down]>
    - define list <server.list_materials.parse[to_lowercase].filter[as_material.is_block].exclude[<[BlackList]>].include[<[Directions]>]>

    - else if <context.args.size> == 1 && <context.raw_args.ends_with[<&sp>]>:
      - determine <[list]>
    - else if <context.args.size> == 2 && !<context.raw_args.ends_with[<&sp>]>:
      - determine <[List].filter[starts_with[<context.args.last>]]>
  Error:
    - define Command "<queue.script.yaml_key[aliases].get[1]||<queue.script.yaml_key[Name]>> "
    - define Hover "<proc[Colorize].context[You typed:|red]><&r><&nl><&c>//Replace <context.raw_args><&nl><&2>C<&a>lick to <&2>I<&a>nsert<&nl><&6>Syntax<&co> <queue.script.yaml_key[Use].parsed>"
    - define Message "<proc[Colorize].context[<[Reason]>|red]>"
    - narrate <proc[MsgHint].context[<[Message]>|<[Command]>|<[Hover]>]>
    - stop
  ClipboardSave:
    - define YamlNum <yaml[<player>].read[BehrEdit.Clipboard.undo.blocks].size.add[1]||1>
    - if <[Blocks].size> != 0:
      - yaml id:<player> set BehrEdit.Clipboard.Undo.Blocks:->:<[YamlNum]>burrito<[Blocks].escaped>
      - yaml id:<player> set BehrEdit.Clipboard.Undo.Materials:->:<[YamlNum]>burrito<[Blocks].parse[Material].escaped>
      - yaml id:<player> savefile:data/pData/<player.uuid>.yml
  script:
    - if <player.location.pitch> < -45:
      - define Direction Up
    - else if <player.location.pitch> > 50:
      - define Direction Down
    - else:
      - define Direction <player.location.yaw.simple>
    - define Cuboid <player.flag[BehrEdit.Selection.Cuboid].as_cuboid>
    - define Path <list[NORTH/0,0,-1|EAST/1,0,0|SOUTH/0,0,1|WEST/-1,0,0|UP/0,1,0|DOWN/0,-1,0]>
    
    - if <context.args.get[1]||null> == null:
      - define Distance 1
    - else if <context.args.get[1].is_integer>:
      - define Distance <context.args.get[1]>:
    - else if <server.list_materials.parse[to_lowercase].filter[as_material.is_block]]>:
      - define Distance 1
      - define StaticMaterial <context.args.get[1]>

    - define Blocks <[Cuboid].blocks.filter[material.name.is[!=].to[air]]>
    - inject Locally ClipboardSave Instantly
    - foreach <[Blocks]> as:Block:
      - define Material <[StaticMaterial]||<[Block].material.name>>
      - modifyblock <[Block].add[<[Path].map_get[<[Direction]>].as_location.mul[<[Distance]>]>]> <[Material]>
      - if <[Loop_Index].mod[100]> == 1:
          - wait 1t


