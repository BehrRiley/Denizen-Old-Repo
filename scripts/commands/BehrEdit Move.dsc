# | ███████████████████████████████████████████████████████████
# % ██    //Move - used to move blocks a number of blocks in
# % ██    a specific coordinated direction
# | ██
# % ██    //move 1
# | ██
# % ██  [ Command ] ██
# $ ██  [ TO-DO   ] ██ | add feature for multi-directional - ie, //move iron_block 5 north 5 up 5 east
Move_Command:
  type: command
  name: /move
  debug: false
  description: Moves selection a direction, optionally only by material(s)
  useage: //move <#> (Direction)
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
  script:
    #----+ Queue Verify +----
    - if <player.has_flag[behredit.process.queue]>:
      - if !<player.has_flag[behredit.process.bypass]>:
        - narrate "<proc[colorize].context[Queue in process. Repeat to bypass.|yellow]>"
        - flag player behredit.process.bypass duration:10s
        - stop
      - else:
        - flag <player> behredit.process.queue:->:<queue>
        - narrate "<proc[colorize].context[[Notice] There are [<player.has_flag[behredit.process.queue].size>] queues in process.|yellow]>"

    #----+ Distance +----
    - if <context.args.get[1]||null> == null:
      - define Distance 1
    - else if <context.args.get[1].is_integer>:
      - define Distance <context.args.get[1]>:
    #----+ Direction +----
    - if <context.args.get[2]||null> == null:
      - if <player.location.pitch> < -45:
        - define Direction Up
      - else if <player.location.pitch> > 50:
        - define Direction Down
      - else:
        - define Direction <player.location.yaw.simple>
    - else if <list[NORTH|EAST|SOUTH|WEST|UP|DOWN].contains[<context.args.get[2]>]>:
      - define Direction <context.args.get[2]>
    - else:
      - define reason "Not a valid direction: <context.args.get[2]>"
      - inject locally Error Instantly
    #----+ Data Set +----
    - define Path <list[NORTH/0,0,-1|EAST/1,0,0|SOUTH/0,0,1|WEST/-1,0,0|UP/0,1,0|DOWN/0,-1,0]>
    - define Cuboid <player.flag[BehrEdit.Selection.Cuboid].as_cuboid>
    #----+ Data Save +----
    - define BlocksSet1 <[Cuboid].blocks.filter[material.name.is[!=].to[air]]>
    - define BlocksSet2 <[BlocksSet1].parse[add[<[Path].map_get[<[Direction]>].as_location.mul[<[Distance]>]>]]>
    - define Materials1 <[BlocksSet1].parse[material.name]>
    - inject BehrEdit_Undo_Save_Volatile Instantly

    - define Chunks <player.flag[BehrEdit.Selection.Cuboid].as_cuboid.list_partial_chunks>
    - foreach <[Chunks]> as:Chunk:
      - wait 1t
      - define BlocksChunkSet1 <[BlocksSet1].filter[chunk.is[==].to[<[Chunk]>]]>
      - define BlockChunkSet2 <[BlocksSet2].parse[add[<[Path].map_get[<[Direction]>].as_location.mul[<[Distance]>]>]]>
      - define MaterialChunkSet1 <[Materials1].filter[chunk.is[==].to[<[Chunk]>]]>
      - foreach <[BlocksChunkSet1]> as:Block:
        - modifyblock <[Block]> air
      - define BlockChunkSet2 <[BlocksSet2].parse[add[<[Path].map_get[<[Direction]>].as_location.mul[<[Distance]>]>]]>
      - foreach <[BlocksSet2]> as:Block:
        - modifyblock <[Block]> <[Materials1].get[<[Loop_Index]>]>
    - if <player.flag[Behredit.Position.IrregularPoly].size||0> > 2:
      - foreach <player.flag[Behredit.Position.IrregularPoly]> as:FlagLoc:
        - define List:->:<[FlagLoc].as_location.add[<[Path].map_get[<[Direction]>].as_location.mul[<[Distance]>]>]>
      - flag player Behredit.Position.IrregularPoly:!
      - flag player Behredit.Position.IrregularPoly:|:<[List]>
      - flag player BehrEdit.Selection.Cuboid:<cuboid[<[List]>]||0>
    - else:
       - flag player BehrEdit.Selection.Cuboid:<cuboid[<[Cuboid].min.add[<[Path].map_get[<[Direction]>].as_location.mul[<[Distance]>]>]>|<[Cuboid].max.add[<[Path].map_get[<[Direction]>].as_location.mul[<[Distance]>]>]>]>

    - flag <player> behredit.process.queue:<-:<queue>
    - narrate "<proc[Colorize].context[Moved: [<[BlocksSet1].size>] blocks in direction: [<[Direction].to_titlecase>]|yellow]>"
