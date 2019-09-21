teleport_Command:
    type: command
    name: teleport
    debug: false
    description: Teleports you to the first player, or the first player to the second.
    use: "<proc[colorize].context[/teleport <&lt>PlayerName<&gt> (<&lt>PlayerName<&gt>)*|yellow]>"
    aliases:
        - tp
    error:
        - define Command "<queue.script.yaml_key[aliases].get[1]||<queue.script.yaml_key[Name]>> "
        - define Hover "<proc[Colorize].context[You typed:|red]><&r><&nl><&c>/tp <context.raw_args><&nl><&2>C<&a>lick to <&2>I<&a>nsert<&nl><&6>Syntax<&co> <queue.script.yaml_key[Use].parsed>"
        - define Message "<proc[Colorize].context[<[Reason]>|red]>"
        - narrate <proc[MsgHint].context[<[Message]>|<[Command]>|<[Hover]>]>
        - stop
    script:
        - if <context.args.get[1]||null> == null:
            - inject Command_Syntax Instantly
        - if <context.args.get[2]||null> == null:
            - define User <context.args.get[1]>
            - inject Player_Verification Instantly
            - if <[User]> == <player>:
                - define reason "You cannot teleport to yourself."
                - inject Command_Error Instantly
            - else:
                - teleport <player> <[User].location>
        - else:
            - foreach <context.raw_args.split[<&sp>].get[1].to[<context.args.size.sub[1]>]> as:User:
                - inject Player_Verification
                - if <[PlayerList].contains[<[User]>]||false>:
                    - define reason "<[User].name> was entered more than once."
                    - inject Command_Error Instantly
                - if <[User]> == <player>:
                    - define reason "You cannot teleport to yourself."
                    - inject Command_Error Instantly
                - define PlayerList:->:<[User]>
            - define User <context.args.last>
            - inject Player_Verification
            - foreach <[PlayerList]> as:Player:
                - teleport <[Player]> <[User].location>
                - narrate targets:<[Player]> "<proc[Colorize].context[You were teleported to:|green]> <&r><[User].name.display>"
            - if <[PlayerList].size> > 1:
                - define WasWere were
            - else:
                - define WasWere was
            - narrate targets:<[User]> "<[PlayerList].parse[name.display].formatted> <&r><proc[Colorize].context[<[WasWere]> teleported to you.|green]>"