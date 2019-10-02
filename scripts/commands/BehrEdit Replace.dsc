# | ███████████████████████████████████████████████████████████
# % ██    //replace - used to replace any set of blocks with
# % ██    another block type, or types, based on percentages
# | ██
# % ██    //replace glass        |Replaces all non-air blocks with glass
# % ██    //replace dirt stone   |Replaces all dirt blocks with stone
# % ██    //replace dirt air stone air grass_block glass     |Replaces all dirt and stone with air, grass_block with glass.
# % ██    //replace stone 25%stone_brick,25%stone,25%andesite,25%cobblestone dirt 20%coarse_dirt,60%dirt,10%grass_block,5%grass_path,5%gravel  |self explainatory
# | ██
# % ██  [ Command ] ██
# $ ██  [ TO-DO   ] ██ | look for switches and opportunities
Replace_Command:
    type: command
    name: /replace
    debug: false
    description: Replaces a material with another material
    aliases:
      - /r
    usage: //replace (Material{NotAir}) <Material>
    tab complete:
      - define BlackList <list[Grass|Bedrock]>
      - define list <server.list_materials.parse[to_lowercase].filter[as_material.is_block].exclude[<[BlackList]>]>
      - if <context.args.size||0> == 0:
        - determine <[list]>
      - if <context.args.size.mod[2]> == 0:
        - determine <[List].filter[starts_with[<context.args.last>]]>
      - else if <context.args.size.mod[2]> == 1:
        - if !<context.raw_args.ends_with[<&sp>]>:
          - if <[List].filter[starts_with[<context.args.last>]].size> == 1 && <context.args.size> > 2:
            - if <[List].filter[starts_with[<context.args.last>]].get[1]> != <context.args.last>:
              - determine <[List].filter[starts_with[<context.args.last>]]>
            - else:
              - determine "<&4>Specify Second Material"
          - determine <[List].filter[starts_with[<context.args.last>]]>
        - else:
          - if <context.args.size> < 2:
            - determine <[List].filter[starts_with[<context.args.last>]]>
          - else:
            - determine "<&4>Specify Second Material"
    Error:
      - define Command "<queue.script.yaml_key[aliases].get[1]||<queue.script.yaml_key[Name]>> "
      - define Hover "<proc[Colorize].context[You typed:|red]><&r><&nl><&c>//Replace <context.raw_args><&nl><&2>C<&a>lick to <&2>I<&a>nsert<&nl><&6>Syntax<&co> <queue.script.yaml_key[Use].parsed>"
      - define Message "<proc[Colorize].context[<[Reason]>|red]>"
      - narrate <proc[MsgHint].context[<[Message]>|<[Command]>|<[Hover]>]>
      - stop

    script:
    # @ ██ [ Verify Command ] ██
      - define BlackList <list[Grass|Bedrock]>
      - define list <server.list_materials.parse[to_lowercase].filter[as_material.is_block].exclude[<[BlackList]>]>

      #-//replace stone?
      - if <context.args.get[2]||null> == null:
        #-//replace?
        - if <context.args.get[1]||null> == null:
          - inject Command_Syntax Instantly
        - else:
          #-//replace stone
          - define Sets 1
          - define FromMaterial1 All
          - define ToMaterial1 <context.args.get[1]>

      #-//replace dirt stone?
      - else:
        #-//replace dirt stone granite?
        - if <context.args.size.mod[2]> == 1:
          - define Reason "Secondary Material Missing For Final Set: <context.args.last>/[?]"
          - inject locally error Instantly
        #-//replace (dirt/stone)+
        - else:
          - define Sets <context.args.size.div[2]>
          - repeat <[Sets]>:
            - define SetVal <[Value].mul[2].sub[2]>
            - define "FromMaterial<[value]>" "<context.args.get[<element[1].add[<[SetVal]>]>]>"
            - define "ToMaterial<[value]>" "<context.args.get[<element[2].add[<[SetVal]>]>]>"

      #-player have selection?
      - if <player.has_flag[BehrEdit.Selection.Cuboid]>:
        - define Cuboid <player.flag[BehrEdit.Selection.Cuboid].as_cuboid>
      - else:
        - define Reason "You must make a selection"
        - inject locally error Instantly
    
      #-materials are valid?
      - define MultiArgs li@
      - foreach <context.args> as:Arg:
        - if <[Arg].contains[%]>:
        #-percentage materials
          - define MultiArgs <[MultiArgs].include[<[Loop_Index]>]>
          - if <[Arg].split[,].parse[before[%]].sum> > 100:
            - define Reason "Percentage Over 100% for <context.args.get[<[Loop_Index]>]>."
            - inject locally error Instantly
          - foreach <[Arg].split[,]> as:MultiArg:
            - if !<[List].contains[<[MultiArg].after[%].as_material.name>]>:
              - if !<[BadMaterials].exists>:
                - define BadMaterials li@
              - define BadMaterials <[BadMaterials].include[<[Arg]>]>
        #-single materials
        - else if !<[List].contains[<[Arg].as_material.name>]>:
          - if !<[BadMaterials].exists>:
            - define BadMaterials li@
          - define BadMaterials <[BadMaterials].include[<[Arg]>]>
      - if <[BadMaterials].size||0> != 0:
        - define Reason "Bad Materials: <[BadMaterials].space_separated>"
        - inject locally Error Instantly
    # @ ██ [ Run Command    ] ██
      - define Blocks <[Cuboid].blocks>
      - repeat <[Sets]>:
        #-//replace {not-air} stone--------------------#
        - define ReplaceList li@
        - if <[FromMaterial<[Value]>]> == All:
          - foreach <[Blocks]> as:Block:
            - if <[Block].material.name> == air:
              - foreach next
            - else:
              - define ReplaceList <[ReplaceList].include[<[Block]>]>
        #-//replace (dirt/stone)+
        - else:
          - foreach <[Blocks]> as:Block:
            - if <[Block].material.name> == <[FromMaterial<[Value]>]>:
              - define ReplaceList <[ReplaceList].include[<[Block]>]>
        #----------------------------------------------#
        - define Blocks <[ReplaceList]>
        - inject BehrEdit_Undo_Save_Static
        
        - if <[MultiArgs].contains[<[Value].mul[2]>]> || <context.args.get[1].contains[%]>:
          - define ModReplaceList null
          - foreach <[ToMaterial<[Value]>].split[,]> as:MultiArg:
            - define ModReplaceList <[ReplaceList].random[<[ReplaceList].size.mul[<[MultiArg].before[%].div[100]>].round_down>]>
            - if <[MultiArgs].size> != <[Loop_Index]>:
              - define ReplaceList:<-:<[ModReplaceList]>
            - else:
              - define ModReplaceList <[ReplaceList]>
            - foreach <[ModReplaceList]> as:Block:
              - modifyblock <[Block]> <[MultiArg].after[%]>
              - if <[Loop_Index].mod[100]> == 1:
                  - wait 1t
          - define text "Replaced [<[ReplaceList].size>] blocks with <[ToMaterial<[Value]>].split[,].formatted.replace[<&pc>].with[<&pc> ]>."
        - else:
          - foreach <[ReplaceList]> as:Block:
            - modifyblock <[Block]> <[ToMaterial<[Value]>]>
            - if <[Loop_Index].mod[100]> == 1:
                - wait 1t
          - define text "Replaced [<[ReplaceList].size>] blocks with <[ToMaterial<[Value]>]>."

        - define Message "<proc[Colorize].context[<[Text]||Nothing interesting happens.>|yellow]>"
        - if <context.args.get[2]||null> == null:
          - define Command "/Undo"
          - define Hover "<proc[Colorize].context[Click to Reverse Command:|green]><&nl><proc[Colorize].context[//undo|yellow]>"
        - else if <[ReplaceList].size> > 0:
          - define Command "/replace <[ToMaterial<[Value]>]> <[FromMaterial<[Value]>]>"
          - define Hover "<proc[Colorize].context[Click to Reverse Command:|green]><&nl><proc[Colorize].context[//replace <[ToMaterial<[Value]>]> <[FromMaterial<[Value]>]>|yellow]>"
        - else:
          - define Command "/replace "
          - define Hover "<proc[Colorize].context[Nothing was replaced. You entered:|red]><&nl><&c>//replace <[FromMaterial<[Value]>]> <[ToMaterial<[Value]>]><&nl><&2>C<&a>lick to <&2>I<&a>nsert<&nl><&6>Syntax<&co> <script.yaml_key[Use].parsed>"
        - narrate <proc[MsgHint].context[<def[Message]>|<def[Command]>|<def[Hover]>]>
