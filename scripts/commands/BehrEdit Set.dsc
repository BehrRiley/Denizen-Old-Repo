# | ███████████████████████████████████████████████████████████
# % ██    //set - used to set the entirity of a selection to
# % ██    another block type, or types, based on percentages
# | ██
# % ██  [ Command ] ██
# $ ██  [ TO-DO   ] ██ | look for switches and opportunities
Set_Command:
    type: command
    name: /set
    debug: false
    description: Sets a selection to a material
    aliases:
        - /set
    use: "<proc[colorize].context[//set <&lt>Material<&gt>|yellow]>"
    tab complete:
        - define BlackList <list[Grass|Bedrock]>
        - define list <server.list_materials.parse[to_lowercase].filter[as_material.is_block].exclude[<[BlackList]>]>
        - if <context.args.size||0> == 0:
            - determine <[list]>
        - else if <context.args.size> == 1 && !<context.raw_args.ends_with[<&sp>]>:
            - determine <[List].filter[starts_with[<context.args.last>]]>
    Error:
        - define Command "<queue.script.yaml_key[aliases].get[1]||<queue.script.yaml_key[Name]>> "
        - define Hover "<proc[Colorize].context[You typed:|red]><&r><&nl><&c>//set <context.raw_args><&nl><&2>C<&a>lick to <&2>I<&a>nsert<&nl><&6>Syntax<&co> <queue.script.yaml_key[Use].parsed>"
        - define Message "<proc[Colorize].context[<[Reason]>|red]>"
        - narrate <proc[MsgHint].context[<[Message]>|<[Command]>|<[Hover]>]>
        - stop
    script:
        # @ ██ [ Verify Command ] ██
        - define BlackList <list[Grass|Bedrock]>
        - define list <server.list_materials.parse[to_lowercase].filter[as_material.is_block].exclude[<[BlackList]>]>
    
        - if <context.args.get[1]||null> || <context.args.get[2]||null> != null:
            - inject Command_Syntax Instantly
        - else:
            - if <player.has_flag[BehrEdit.Selection.Cuboid]>:
                - define Cuboid <player.flag[BehrEdit.Selection.Cuboid].as_cuboid>
            - else:
                - define Reason "You must make a selection"
                - inject locally error Instantly

        #-materials are valid?
        - define Material <context.args.get[1]>
        #-percentage materials
        - if <[Material].contains[%]>:
            - if <[Material].split[,].parse[before[%]].sum> > 100:
                - define Reason "Percentage Over 100% for <context.args.get[<[Loop_Index]>]>."
                - inject locally error Instantly
            - foreach <[Material].split[,]> as:MultiArg:
                - if !<[List].contains[<[MultiArg].after[%].as_material.name>]>:
                    - define BadMaterials:->:<[Material]>
        #-single materials
        - else if !<[List].contains[<[Material].as_material.name>]>:
            - define BadMaterials:->:<[Material]>
        - if <[BadMaterials].size||0> != 0:
            - define Reason "Bad Materials: <[BadMaterials].space_separated>"
            - inject locally Error Instantly
        # @ ██ [ Run Command    ] ██
        - define Blocks <[Cuboid].blocks>

        - define YamlNum <yaml[<player>].read[BehrEdit.Clipboard.undo.blocks].size.add[1]||1>
        - if <[Blocks].size> != 0:
            - yaml id:<player> set BehrEdit.Clipboard.Undo.Blocks:->:<[YamlNum]>burrito<[Blocks].escaped>
            - yaml id:<player> set BehrEdit.Clipboard.Undo.Materials:->:<[YamlNum]>burrito<[Blocks].parse[Material].escaped>
            - yaml id:<player> savefile:data/pData/<player.uuid>.yml


        - foreach <[Blocks]> as:Block:
            - modifyblock <[Block]> <[Material]>
            - if <[Loop_Index].mod[100]> == 1:
                - wait 1t

        
        #- define text "Set [<[Blocks].size>] blocks with <[ToMaterial<[Value]>]>."
        - narrate "<proc[Colorize].context[Changed:|green]> <&6>[<&e><[Blocks].size><&6>] <&2>b<&a>locks"
