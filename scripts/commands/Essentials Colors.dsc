Colors_Command:
    type: command
    name: colors
    debug: false
    description: Lists the colors in a click-menu
    usage: /colors
    script:
        - if <context.args.get[1]||null> != null
            - Inject Command_Syntax Instantly
        - define Colors <list[&0|&1|&2|&3|&4|&5|&6|&7|&8|&9|&a|&b|&c|&d|&e|&f]>
        - narrate "<&2>+<element[<&a>Shift-Click To Insert].pad_left[28].with[-]><&2>-----+""
        - repeat 2:
            - define Text<[value]> li@
            - foreach <[Colors].get[<[value].add[<[value].sub[1].mul[7]>]>].to[<[value].add[<[value].sub[1].mul[8]>].add[7]>]> as:Color:
                - define Text<[value]> '<[Text<[value]>].include[{"text":"<[Color].parse_color><[Color]>", "hoverEvent":{"action":"show_text","value":"<&a>Shift click to insert"},"insertion":"<[Color]>"},]>'
            - execute as_op 'tellraw @p ["",<[Text<[value]>].separated_by[{"text":"<&sp><&sp>"},]>""]'

        - define formats "<List[&k/tacos|&l/Bold|&M/Strike|&r/ Reset|&o/Italic|&n/Underline]>"
        - repeat 3:
            - define Text<[value].add[2]> li@
            - foreach <[Formats].get[<[value].mul[2].sub[1]>].to[<[value].mul[2]>]> as:Format:
                - define Text<[value].add[2]> '<[Text<[value].add[2]>].include[{"text":"<&r><[Format].split[/].get[1]> <[Format].replace[/].with[].parse_color><&r>", "hoverEvent":{"action":"show_text","value":"<&a>Shift click to insert"},"insertion":"<[Format].split[/].get[1]>"},]>'
            - execute as_op 'tellraw @p ["",<[Text<[value].add[2]>].separated_by[{"text":"<&sp><&sp><&sp><&sp>"},]>""]'
        - narrate "<&8>[<&7>Note<&8>]<&7>: Color before Formats!<&nl><&2>+<element[].pad_left[22].with[-]><&2>-----+"


