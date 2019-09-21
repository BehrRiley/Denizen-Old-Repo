Fill_Command:
    type: command
    name: /fill
    debug: false
    description: Fills a space with a material
    aliases:
        - /f
    use: "<proc[colorize].context[//replace (Material{NotAir}) <&lt>Material<&gt>|yellow]>"
    Dirx:
        NORTH: 0,0,-1
        EAST: 1,0,0
        SOUTH: 0,0,1
        WEST: -1,0,0
        UP: 0,1,0
        DOWN: 0,-1,0
    Error:
        - define Command "<queue.script.yaml_key[aliases].get[1]||<queue.script.yaml_key[Name]>> "
        - define Hover "<proc[Colorize].context[You typed:|red]><&r><&nl><&c>//Replace <context.raw_args><&nl><&2>C<&a>lick to <&2>I<&a>nsert<&nl><&6>Syntax<&co> <queue.script.yaml_key[Use].parsed>"
        - define Message "<proc[Colorize].context[<[Reason]>|red]>"
        - narrate <proc[MsgHint].context[<[Message]>|<[Command]>|<[Hover]>]>
        - stop
    script:
        - if !<player.has_flag[TestingCommands]>:
            - narrate "<proc[colorize].context[This is a developmental command.>"
            - determine cancelled
        - define Location <player.location.cursor_on>
        - define AirBlocks <list[<[Location]>]>
        - define Blocks li@
        - define Blacklist li@
        - define loop:0

        #- run testclear def:<queue>

        - wait 1s
        - while <[Blocks].size> < 1000 || <[AirBlocks].size> == 0:
            - foreach <[AirBlocks]> as:AirBlock:
                - modifyblock <[AirBlock]> black_stained_glass
                - define AirBlocks:<-:<[AirBlock]>
                - define Blocks:->:<[AirBlock]>
                - foreach <list[0,0,-1|1,0,0|0,0,1|-1,0,0|0,1,0|0,-1,0]> as:Dir:
                    - if <[AirBlock].add[<[Dir]>].material.name> == air:
                        - if !<[AirBlocks].contains[<[AirBlock].add[<[Dir]>]>]>:
                            - define AirBlocks:->:<[AirBlock].add[<[Dir]>]>
                        - define AirLock:++
                        - while <[AirLock]> > 0:
                            - if <[AirBlock].add[<[Dir].as_location.mul[<[Loop_Index].add[1]>]>].material.name> == air:
                                - if !<[AirBlocks].contains[<[AirBlock].add[<[Dir].as_location.mul[<[Loop_Index].add[1]>]>]>]>:
                                    - define AirBlocks:->:<[AirBlock].add[<[Dir].as_location.mul[<[Loop_Index].add[1]>]>]>
                            - else:
                                - define AirLock 0
                    - else:
                        - if <[Tacos]||0> == 6:
                            - define AirBlocks:<-:<[AirBlock]>
                        - else:
                            - define Tacos:++
                - if <[Blocks].size.mod[100]> == 1:
                    - wait 1t
        - debug approval "Completed filling, replaced [<[Blocks].size>] with Air - completed in <queue.time_ran>"
        - narrate "<proc[Colorize].context[Completed filling, replaced [<[Blocks].size>] with Air|yellow]><&2>; <&a>completed in <queue.time_ran.formatted>"

        #- foreach <[Blocks]> as:block:
        #    - define ID <[Block].chunk.after[ch@].before_last[,]>
        #    - if yaml <[ID]> doesn't exist,
        #        - create it
        #    - yaml id:<[ID]> set block:<[Block]>



testclear:
    type: task
    definitions: queue
    script:
        - wait 5s
        - queue <[Queue]> clear

Fill_Handler:
    type: world
    debug: false
    events:
        on fill command:
            - inject
            - narrate "hi use two slashes for now"


            #$/ex queue <queue.list.exclude[<queue>].get[1]> clear