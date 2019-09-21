Report_Command:
    type: command
    name: report
    debug: true
    description: Reports a bug, an issue, or makes a suggestion directly to the coordinator.
    use: "<proc[colorize].context[/report <&lt>message<&gt>|yellow]>"
    script:
        - if <context.args.get[1]||null> == null:
            - inject Command_Syntax Instantly
        - define Message <script[ReportForm].yaml_key[form].separated_by[<&nl>]>
        - discord id:GeneralBot message channel:623750914775187466 "<[Message].parsed.unescaped||error>"


ReportForm:
    type: yaml data
    form:
        - "> **Reporting Player**:`<player.name>` | `<player.name.display.strip_color>`"
        - "> **UUID**: `<player.uuid>`"
        - "> **Player Data:**"
        - "> Location: `<bungee.server>` | `<player.world.name>` | `<player.location.simple.before[,<player.world.name>]>`"
        - "> ```<context.raw_args.escaped.replace[`].with[']>```"