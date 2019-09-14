# | ███████████████████████████████████████████████████████████
# % ██    //Pos1 Command for positioning with BehrEdit
# | ██
# % ██  [ Command ] ██
# $ ██  [ TO-DO   ] ██ | actually write the script | Eventually add Grief Prevention switch
Position1_Command:
    type: command
    name: /position1
    debug: true
    description: Manually sets position one for BehrEdit.
    aliases:
      - /pos1
    use: "<proc[colorize].context[//position1 (<&lt>X Y Z<&gt>) (Size:<&lt>#<&gt> (Direction:))|yellow]>"
    tab complete:
      - if <context.args.size||0> == 0:
        - determine <player.location.x.round_up>
      - else if <context.args.size> == 1 && !<context.raw_args.ends_with[<&sp>]>:
        - determine <player.location.x.round_up>
      - else if <context.args.size> == 1 && <context.raw_args.ends_with[<&sp>]>:
        - determine <player.location.y.round_up>
      - else if <context.args.size> == 2 && !<context.raw_args.ends_with[<&sp>]>:
        - determine <player.location.y.round_up>
      - else if <context.args.size> == 2 && <context.raw_args.ends_with[<&sp>]>:
        - determine <player.location.z.round_up>
      - else if <context.args.size> == 3 && !<context.raw_args.ends_with[<&sp>]>:
        - determine <player.location.z.round_up>
      - else if <context.args.size> == 3 && <context.raw_args.ends_with[<&sp>]>:
        - determine <list[size:|s:]>
      - else if <context.args.size> == 4 && !<context.raw_args.ends_with[<&sp>]> && !<context.args.last.contains_any[size:|s:]> && !<context.args.last.contains[:]>:
        - determine <list[size:|s:]>
      - else if <context.args.size> == 4 && <context.raw_args.ends_with[<&sp>]>:
        - determine <list[direction:|d:]>
      - else if <context.args.size> == 5 && !<context.raw_args.ends_with[<&sp>]> && !<context.args.last.contains_any[direction:|d:]> && !<context.args.last.contains[:]>:
        - determine <list[direction:|d:]>
      - else if <context.args.size> == 5 && !<context.raw_args.ends_with[<&sp>]> && <context.args.last.contains[:]>:
        - if <context.raw_args.ends_with[direction:]>:
          - determine <list[direction:north|direction:south|direction:east|direction:west|direction:up|direction:down]>
        - else if <context.raw_args.ends_with[d:]>:
          - determine <list[d:north|d:south|d:east|d:west|d:up|d:down]>
      - else if <context.args.size> == 5 && !<context.raw_args.ends_with[<&sp>]>:
        - if <context.raw_args.contains[direction:]>:
          - determine <list[direction:north|direction:south|direction:east|direction:west|direction:up|direction:down].filter[starts_with[<context.args.last>]]>
        - else if <context.raw_args.contains[d:]>:
          - determine <list[d:north|d:south|d:east|d:west|d:up|d:down].filter[starts_with[<context.args.last>]]>

    Error:
      - define Command "<queue.script.yaml_key[aliases].get[1]||<queue.script.yaml_key[Name]>> "
      - define Hover "<proc[Colorize].context[You typed:|red]><&r><&nl><&c>//Replace <context.raw_args><&nl><&2>C<&a>lick to <&2>I<&a>nsert<&nl><&6>Syntax<&co> <queue.script.yaml_key[Use].parsed>"
      - define Message "<proc[Colorize].context[<[Reason]>|red]>"
      - narrate <proc[MsgHint].context[<[Message]>|<[Command]>|<[Hover]>]>
      - stop

    script:
    # @ ██ [ Verify Command ] ██
    - if <context.args.get[1]||null>:
      - narrate do position 1
    - else:
      - if <context.args.get[1].contains_any[s:|size:]>
        - do size PlayerVector Cuboid
      - else if <context.args.get[3]||null> == null || <context.raw_args.contains_any[d:|distance:]>:
        - inject Command_Syntax Instantly

