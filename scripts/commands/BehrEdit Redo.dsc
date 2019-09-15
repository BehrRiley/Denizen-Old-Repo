# | ███████████████████████████████████████████████████████████
# % ██   //Redo Command
# | ██
# % ██  [ Command ] ██
# $ ██  [ TO-DO   ] ██ | add # features, ie, //redo 5 to undo last five, or //redo at:2 to undo second to last edit, skipping the first
Redo_Command:
    type: command
    name: redo
    debug: true
    description: Reverses edit from redo-clipboard
    aliases:
        - /redo
        - redo
    use: "<proc[colorize].context[//replace (Material{NotAir}) <&lt>Material<&gt>|yellow]>"
    tab complete:
        - if <context.args.size||0> == 0:
            - determine <list[#|at:#]>
    script:
        - if <context.args.get[2]||null> != null:
            - inject Command_Syntax instantly
        - if <context.args.get[1]||null> == null:
            - define YamlNum <yaml[<player>].read[BehrEdit.Clipboard.redo.blocks].size||1>
        - else if <context.args.get[1].is_integer>:
            - if <yaml[<player>].read[BehrEdit.Clipboard.redo.blocks].size||1> < <context.args.get[1]>:
                - define YamlNum <context.args.get[1]>
            - else:
                - narrate "No redo in clipboard for that index: <context.args.get[1]>"
        - else:
            - inject Command_Syntax instantly

        - define Blocks <yaml[<player>].read[BehrEdit.Clipboard.redo.Blocks].get[<[YamlNum]>].after[<[YamlNum]>tacos].unescaped>
        - define Materials <yaml[<player>].read[BehrEdit.Clipboard.redo.Materials].get[<[YamlNum]>].after[<[YamlNum]>tacos].unescaped>
        - foreach <[Blocks]> as:Block:
            - define UndoMaterialList:->:<[Block].material>
            - modifyblock <[Block]> <[Materials].get[<[Loop_index]>]>
            - if <[Loop_Index].mod[100]> == 1:
                - wait 1t

        - if <[Blocks].size> != 0:
            - define UndoYamlNum <yaml[<player>].read[BehrEdit.Clipboard.Undo.blocks].size.add[1]||1>
            - yaml id:<player> set BehrEdit.Clipboard.Undo.Blocks:->:<[UndoYamlNum]>burrito<[Blocks].escaped>
            - yaml id:<player> set BehrEdit.Clipboard.Undo.Materials:->:<[UndoYamlNum]>burrito<[UndoMaterialList].escaped>
            - yaml id:<player> set BehrEdit.Clipboard.Redo.Blocks:<-:<[YamlNum]>Tacos<[Blocks].escaped>
            - yaml id:<player> set BehrEdit.Clipboard.Redo.Materials:<-:<[YamlNum]>Tacos<[Materials].escaped>
            - yaml id:<player> savefile:data/pData/<player.uuid>.yml
            - narrate "<proc[Colorize].context[Reversed edit from redo-clipboard:|green]> <&6>[<&e><[YamlNum]><&6>]"