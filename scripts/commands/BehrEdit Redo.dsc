# | ███████████████████████████████████████████████████████████
# % ██   //Redo Command
# | ██
# % ██  [ Command ] ██
# $ ██  [ TO-DO   ] ██ | add # features, ie, //redo 5 to undo last five, or //redo at:2 to undo second to last edit, skipping the first
Redo_Command:
    type: command
    name: redo
    debug: false
    description: Reverses edit from redo-clipboard
    use: "<proc[colorize].context[//replace (Material{NotAir}) <&lt>Material<&gt>|yellow]>"
    tab complete:
        - if <context.args.size||0> == 0:
            - determine <list[#|at:#]>
    script:
        - if <context.args.get[2]||null> != null:
            - inject Command_Syntax instantly
        - if <context.args.get[1]||null> == null:
            - define YamlRedoSize <yaml[<player>].read[BehrEdit.Clipboard.redo.static.blocks].size||0>
        - else if <context.args.get[1].is_integer>:
            - if <yaml[<player>].read[BehrEdit.Clipboard.redo.static.blocks].size||0> < <context.args.get[1]>:
                - define YamlRedoSize <context.args.get[1]>
            - else:
                - narrate "No redo in clipboard for that index: <context.args.get[1]>"
                - stop
        - else:
            - inject Command_Syntax instantly
        - if <yaml[<player>].read[BehrEdit.Clipboard.Redo.Order].size||0> == 0:
            - narrate "<proc[Colorize].context[Nothing left to redo.|red]>"
            - stop

        - define YamlOrderRSize <yaml[<player>].read[BehrEdit.Clipboard.Redo.Order].size||0>
        - define YamlOrderType <yaml[<player>].read[BehrEdit.Clipboard.Redo.Order].last.after[<[YamlOrderRSize]>]>
        - if <[YamlOrderType]> == Static:
            - define Blocks <yaml[<player>].read[BehrEdit.Clipboard.Redo.static.blocks].get[<[YamlRedoSize]>].after[<[YamlRedoSize]>tacos].unescaped>
            - define Materials <yaml[<player>].read[BehrEdit.Clipboard.Redo.static.Materials].get[<[YamlRedoSize]>].after[<[YamlRedoSize]>tacos].unescaped>
            - foreach <[Blocks]> as:Block:
                - define UndoMaterialList:->:<[Block].material.name>
                - modifyblock <[Block]> <[Materials].get[<[Loop_index]>]>
                - if <[Loop_Index].mod[100]> == 1:
                    - wait 1t

            - if <[Blocks].size> != 0:
                - define YamlUndoSize <yaml[<player>].read[BehrEdit.Clipboard.Undo.static.blocks].size||0>
                - define YamlOrderUSize <yaml[<player>].read[BehrEdit.Clipboard.Undo.Order].size||0>
                - yaml id:<player> set BehrEdit.Clipboard.Undo.static.blocks:->:<[YamlUndoSize].add[1]>burrito<[Blocks].escaped>
                - yaml id:<player> set BehrEdit.Clipboard.Undo.static.Materials:->:<[YamlUndoSize].add[1]>burrito<[UndoMaterialList].escaped>
                - yaml id:<player> set BehrEdit.Clipboard.Undo.Order:->:<[YamlOrderUSize].add[1]>Static
                - yaml id:<player> set BehrEdit.Clipboard.Redo.static.blocks:<-:<[YamlRedoSize]>Tacos<[Blocks].escaped>
                - yaml id:<player> set BehrEdit.Clipboard.Redo.static.Materials:<-:<[YamlRedoSize]>Tacos<[Materials].escaped>
                - yaml id:<player> set BehrEdit.Clipboard.Redo.Order:<-:<[YamlOrderRSize]>Static
                - yaml id:<player> savefile:data/pData/<player.uuid>.yml
                - define Message "<proc[Colorize].context[Reversed edit from redo-clipboard:|green]> <&6>[<&e><[YamlRedoSize]><&6>]"
                - define Command "/undo"
                - define Hover "<proc[Colorize].context[Click to Undo|green]> <&6>[<&e><[YamlRedoSize]><&6>]"
                - narrate <proc[MsgCommand].context[<def[Message]>|<def[Command]>|<def[Hover]>]>
        - else if <[YamlOrderType]> == Volatile:
            - narrate hi