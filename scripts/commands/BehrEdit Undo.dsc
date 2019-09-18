# | ███████████████████████████████████████████████████████████
# % ██   //Undo Command
# | ██
# % ██  [ Command ] ██
# $ ██  [ TO-DO   ] ██ | add # features, ie, //undo 5 to undo last five, or //undo at:2 to undo second to last edit, skipping the first
Undo_Command:
    type: command
    name: undo
    debug: false
    description: Reverses edit from undo-clipboard
    aliases:
        - /undo
        - undo
    use: "<proc[colorize].context[//undo (#)|yellow]>"
    tab complete:
        - if <context.args.size||0> == 0:
            - determine <list[#|at:#]>
    script:
        - if <context.args.get[2]||null> != null:
            - inject Command_Syntax instantly
        - if <context.args.get[1]||null> == null:
            - define YamlUndoSize <yaml[<player>].read[BehrEdit.Clipboard.Undo.Static.blocks].size||0>
        - else if <context.args.get[1].is_integer||false>:
            - if <yaml[<player>].read[BehrEdit.Clipboard.Undo.Static.blocks].size||0> < <context.args.get[1]||1>:
                - define YamlUndoSize <context.args.get[1]>
            - else:
                - narrate "<proc[Colorize].context[No undo in clipboard for that index: <context.args.get[1]>|red]>"
                - stop
        - else:
            - inject Command_Syntax instantly
        - if <yaml[<player>].read[BehrEdit.Clipboard.Undo.Order].size||0> == 0:
            - narrate "<proc[Colorize].context[Nothing left to undo.|red]>"
            - stop
        
        - define YamlOrderUSize <yaml[<player>].read[BehrEdit.Clipboard.Undo.Order].size>
        - define YamlOrderType <yaml[<player>].read[BehrEdit.Clipboard.Undo.Order].last.after[<[YamlOrderUSize]>]>
        - if <[YamlOrderType]> == Static:
            - define Blocks <yaml[<player>].read[BehrEdit.Clipboard.Undo.Static.Blocks].get[<[YamlUndoSize]>].after[<[YamlUndoSize]>burrito].unescaped>
            - define Materials <yaml[<player>].read[BehrEdit.Clipboard.Undo.Static.Materials].get[<[YamlUndoSize]>].after[<[YamlUndoSize]>burrito].unescaped>
            - foreach <[Blocks]> as:Block:
                - define RedoMaterialList:->:<[Block].material.name>
                - modifyblock <[Block]> <[Materials].get[<[Loop_index]>]>
                - if <[Loop_Index].mod[100]> == 1:
                    - wait 1t

            - if <[Blocks].size> != 0:
                - define YamlRedoSize <yaml[<player>].read[BehrEdit.Clipboard.Redo.Static.blocks].size||0>
                - define YamlOrderRSize <yaml[<player>].read[BehrEdit.Clipboard.Redo.Order].size||0>
                - yaml id:<player> set BehrEdit.Clipboard.Redo.Static.Blocks:->:<[YamlRedoSize].add[1]>tacos<[Blocks].escaped>
                - yaml id:<player> set BehrEdit.Clipboard.Redo.Static.Materials:->:<[YamlRedoSize].add[1]>tacos<[RedoMaterialList].escaped>
                - yaml id:<player> set BehrEdit.Clipboard.Redo.Order:->:<[YamlOrderRSize].add[1]>Static
                - yaml id:<player> set BehrEdit.Clipboard.Undo.Static.Blocks:<-:<[YamlUndoSize]>burrito<[Blocks].escaped>
                - yaml id:<player> set BehrEdit.Clipboard.Undo.Static.Materials:<-:<[YamlUndoSize]>burrito<[Materials].escaped>
                - yaml id:<player> set BehrEdit.Clipboard.Undo.Order:<-:<[YamlOrderUSize]>Static
                - yaml id:<player> savefile:data/pData/<player.uuid>.yml
                - define Message "<proc[Colorize].context[Reversed edit from undo-clipboard:|green]> <&6>[<&e><[YamlUndoSize]><&6>]"
                - define Command "/redo"
                - define Hover "<proc[Colorize].context[Click to Redo|green]> <&6>[<&e><[YamlUndoSize]><&6>]"
                - narrate <proc[MsgCommand].context[<def[Message]>|<def[Command]>|<def[Hover]>]>
        - else if <[YamlOrderType]> == Volatile:
            - narrate hi



            #$$foreach <player.flag[BehrEdit.Selection.Cuboid].as_cuboid.list_partial_chunks.size>

