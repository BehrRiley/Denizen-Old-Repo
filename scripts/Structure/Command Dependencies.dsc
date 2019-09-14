Command_Syntax:
  type: task
  debug: false
  script:
    - define Command "<queue.script.yaml_key[aliases].get[1]||<queue.script.yaml_key[Name]>> "
    - define Hover "<&2>C<&a>lick to <&2>I<&a>nsert<&nl><&6>Syntax<&co> <queue.script.yaml_key[Use].parsed>"
    - define Message "<&6>S<&e>yntax<&6><&co> <queue.script.yaml_key[Use].parsed>"
    - narrate <proc[MsgHint].context[<[Message]>|<[Command]>|<[Hover]>]>
    - stop

Permission_Verification:
  type: task
  debug: false
  script:
    - if <player.flag[Behrry.Essentials.Rank]> > <[Rank]>
      - define Hover "<proc[Colorize].context[Permission Required:|red]> <&6><[Rank]>"
      - define Message "<proc[Colorize].context[You don't have permission to do that.|red]>"
      - narrate <proc[HoverMsg].context[<[Message]>|<[Hover]>]>
      - stop

Player_Verification:
  type: task
  debug: false
  ErrorProcess:
    - define Message "<proc[Colorize].context[Player is not online or does not exist.|red]>"
    - define Hover "<&6>Y<&e>ou <&6>E<&e>ntered<&co><&nl><&c>/<context.command.to_lowercase> <context.raw_args>"
    - narrate <proc[MsgHover].context[<[Message]>|<[Hover]>]>
    - stop
  script:
    - if <server.match_player[<[User]>]||null> == null:
      - inject locally ErrorProcess Instantly
    - define User <server.match_player[<[User]>]>

Player_Verification_Offline:
  type: task
  debug: false
  ErrorProcess:
    - define Message "<proc[Colorize].context[Player does not exist.|red]>"
    - define Hover "<&6>Y<&e>ou <&6>E<&e>ntered<&co><&nl><&c>/<context.command.to_lowercase> <context.raw_args>"
    - narrate <proc[MsgHover].context[<[Message]>|<[Hover]>]>
    - stop
  script:
    - if <server.match_player[<[User]>]||null> == null:
      - if <server.match_offline_player[<[User]>]||null> == null:
        - inject locally ErrorProcess Instantly
      - else:
        - define User <server.match_offline_player[<[User]>]>
    - else:
      - define User <server.match_player[<[User]>]>