# | ███████████████████████████████████████████████████████████
# % ██   //Undo Command
# | ██
# % ██  [ Command ] ██
# $ ██  [ TO-DO   ] ██ | add # features, ie, //undo 5 to undo last five, or //undo at:2 to undo second to last edit, skipping the first
Undo_Command:
    type: command
    name: undo
    debug: true
    description: Reverses edit from undo-clipboard
    aliases:
        - /undo
        - undo
    use: "<proc[colorize].context[//replace (Material{NotAir}) <&lt>Material<&gt>|yellow]>"
    tab complete:
        - if <context.args.size||0> == 0:
            - determine <list[#|at:#]>
    script:
        - if <context.args.get[2]||null> != null:
            - inject Command_Syntax instantly
        - if <context.args.get[1]||null> == null:
            - define YamlNum <yaml[<player>].read[BehrEdit.Clipboard.undo.blocks].size||1>
        - else if <context.args.get[1].is_integer>:
            - if <yaml[<player>].read[BehrEdit.Clipboard.undo.blocks].size||1> < <context.args.get[1]>:
                - define YamlNum <context.args.get[1]>
            - else:
                - narrate "No undo in clipboard for that index: <context.args.get[1]>"
        - else:
            - inject Command_Syntax instantly

        - define Blocks <yaml[<player>].read[BehrEdit.Clipboard.Undo.Blocks].get[<[YamlNum]>].after[<[YamlNum]>burrito].unescaped>
        - define Materials <yaml[<player>].read[BehrEdit.Clipboard.Undo.Materials].get[<[YamlNum]>].after[<[YamlNum]>burrito].unescaped>
        - foreach <[Blocks]> as:Block:
            - define RedoMaterialList:->:<[Block].material.name>
            - modifyblock <[Block]> <[Materials].get[<[Loop_index]>]>
            - if <[Loop_Index].mod[100]> == 1:
                - wait 1t

        - if <[Blocks].size> != 0:
            - define RedoYamlNum <yaml[<player>].read[BehrEdit.Clipboard.Redo.blocks].size.add[1]||1>
            - yaml id:<player> set BehrEdit.Clipboard.Redo.Blocks:->:<[RedoYamlNum]>tacos<[Blocks].escaped>
            - yaml id:<player> set BehrEdit.Clipboard.Redo.Materials:->:<[RedoYamlNum]>tacos<[RedoMaterialList].escaped>
            - yaml id:<player> set BehrEdit.Clipboard.Undo.Blocks:<-:<[YamlNum]>burrito<[Blocks].escaped>
            - yaml id:<player> set BehrEdit.Clipboard.Undo.Materials:<-:<[YamlNum]>burrito<[Materials].escaped>
            - yaml id:<player> savefile:data/pData/<player.uuid>.yml
            - narrate "<proc[Colorize].context[Reversed edit from undo-clipboard:|green]> <&6>[<&e><[YamlNum]><&6>]"

 






    Redo:
    - define Blocks <player.flag[BehrEdit.Redo.1L]>
    - define Materials <player.flag[BehrEdit.Redo.1M]>
    - flag player BehrEdit.Undo.1L:<[Blocks]>
    - flag player BehrEdit.Undo.1M:<[blocks].parse[material]>
    - flag player BehrEdit.Redo.1L:!
    - flag player BehrEdit.Redo.1M:!
    - foreach <[Blocks]> as:block:
        - define Material <[Materials].get[<[loop_index]>]>
        - ~modifyblock <[Block]> <[Material]>