MsgHoverB:
    type: procedure
    debug: false
    definitions: Hover|Text
    script:
        - determine <&hover[<[Hover].unescaped>]><[Text].unescaped><&end_hover>

MsgCmdB:
    type: procedure
    debug: false
    definitions: Hover|Text|Command
    script:
        - determine <&hover[<[Hover].unescaped>]><&click[/<[Command]>]><[Text].unescaped><&end_click><&end_hover>