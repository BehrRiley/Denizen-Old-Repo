Discord_Command:
    type: command
    name: discord
    debug: false
    description: Gives you the discord link.
    usage: /discord
    script:
        - if <context.args.get[1]||null> != null:
            - inject Command_Syntax Instantly
        - else:
            - define Message "<proc[Colorize].context[Click for the Link to:|yellow]> <&3><&n>D<&b><&n>iscord"
            - define URL "https://discord.gg/ypHfzkr"
            - define Hover "<proc[Colorize].context[Click to follow Link:|green]><&nl><proc[Colorize].context[https://discord.gg/ypHfzkr|blue]>"
            - narrate <proc[msgUrl].context[<def[Message]>|<def[URL]>|<def[Hover]>]>