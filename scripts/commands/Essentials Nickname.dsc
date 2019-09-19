# | ███████████████████████████████████████████████████████████
# % ██    /nick - for changing your nickname / display name
# | ██
# % ██  [ Command ] ██
# $ ██  [ TO-DO   ] ██ | Admin capabilities
Nickname_Command:
    type: command
    name: nickname
    debug: true
    description: Changes your display name.
    admindescription: Changes a your own or another player's display name.
    use: "<proc[colorize].context[/nickname <&lt>Nickname<&gt>|yellow]>"
    adminuse: "<proc[colorize].context[/give (Player) <&lt>Nickname<&gt>|yellow]>"
    aliases:
        - nick
    tab complete:
        - if <context.args.size||0> == 0:
            - determine <server.list_online_players.parse[name]>
        - else if <context.args.size> == 1 && !<context.raw_args.ends_with[<&sp>]>:
            - determine <server.list_online_players.parse[name].filter[starts_with[<context.args.get[1]>]]>
    script:
        - if <context.args.get[1]||null> == null || <context.args.get[3]||null> != null:
            - inject Command_Syntax Instantly
        - if <context.args.get[2]||null> == null:
            - define Nickname <context.args.get[1]>
        - else:
            - define User <context.args.get[1]>
            - define Nickname <context.args.get[2]>
            - inject Player_Verification_Offline Instantly
        - if !<[Nickname].matches[[a-zA-Z0-9-_\&]+]>
            - narrate "Nicknames should be alphanumerical."
            - stop
        - if <[Nickname].length> > 16:
            - narrate "Nicknames should be less than 16 charaters."
            - stop

        - define Message "<proc[Colorize].context[Your nickname has been changed to:|green]> <&r><[Nickname].parse_color>"
        - define Command "nickname <[User].name.display||<player.name.display>>"
        - define Hover "<proc[Colorize].context[Click to revert to:|green]><&nl> <&r><[User].name.display||<player.name.display>>"
        - narrate targets:<[User]||<player>> <proc[MsgHint].context[<def[Message]>|<def[Command]>|<def[Hover]>]>

        - adjust <[User]||<player>> display_name:<[Nickname].parse_color>
        - flag <[User]||<player>> behrry.essentials.display_name:<[Nickname].parse_color>
        