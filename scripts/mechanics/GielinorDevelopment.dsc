Tile_indicator_While:
    type: task
    debug: false
    definitions: RLocations|BLocations
    script:
        - define RLocations <[RLocations].unescaped.as_list>
        - define BLocations <[BLocations].unescaped.as_list>
        - if <player.has_flag[GielinorDevelopment.TileIndicator.Queue]>:
            - if <queue.exists[<player.flag[GielinorDevelopment.TileIndicator.Queue].as_queue.id||false>]>:
                - queue <player.flag[GielinorDevelopment.TileIndicator.Queue].as_queue> clear
            - flag player GielinorDevelopment.TileIndicator.Queue:!

        - flag <player> GielinorDevelopment.TileIndicator.Queue:<queue>
        - if <player.has_flag[GielinorDevelopment.TileIndicator.Monitor]>:
            - define BlackList <list[air|grass|fern|tall_grass]>
            - repeat 1:
                - foreach <[RLocations]> as:RLocation:
                    - if <[Blacklist].contains[<[RLocation].material.name>]>:
                        - if <[Blacklist].contains[<[RLocation].add[0,-2,0].material.name>]>:
                            - define H -2
                        - else if <[Blacklist].contains[<[RLocation].add[0,-1,0].material.name>]>:
                            - define H -1
                        - else:
                            - define H 0
                    - else if <[Blacklist].contains[<[RLocation].add[0,1,0].material.name>]>:
                        - define H 1
                    - else if <[Blacklist].contains[<[RLocation].add[0,2,0].material.name>]>:
                        - define H 2
                    - else:
                        - foreach next
                    - playeffect effect:redstone at:<[RLocation].add[0,<[h]>,0]> offset:0 quantity:1 data:0 special_data:0.75|255,125,0
                - foreach <[BLocations]> as:BLocation:
                    - if <[Blacklist].contains[<[BLocation].material.name>]>:
                        - if <[Blacklist].contains[<[BLocation].add[0,-2,0].material.name>]>:
                            - define H -2
                        - else if <[Blacklist].contains[<[BLocation].add[0,-1,0].material.name>]>:
                            - define H -1
                        - else:
                            - define H 0
                    - else if <[Blacklist].contains[<[BLocation].add[0,1,0].material.name>]>:
                        - define H 1
                    - else if <[Blacklist].contains[<[BLocation].add[0,2,0].material.name>]>:
                        - define H 2
                    - else:
                        - foreach next
                    - playeffect effect:redstone at:<[BLocation].add[0,<[h]>,0]> offset:0 quantity:2 data:0 special_data:0.75|0,125,255
            - wait 5t
            - run Tile_Indicator_Task Instantly def:<[RLocations].escaped>|<[BLocations].escaped> player:<server.match_player[behr]>

Tile_Indicator_Task:
    type: task
    debug: false
    script:
        - define X <player.location.x.round_down>
        - define Z <player.location.z.round_down>
        
        - if <[X].mod[2]> == 1 && <[Z].mod[2]> == 0:
            - define Offset 0,0,0
        - else if <[X].mod[2]> == 0 && <[Z].mod[2]> == 0:
            - define Offset -1,0,0
        - else if <[X].mod[2]> == 1 && <[Z].mod[2]> == 1:
            - define Offset 0,0,-1
        - else if <[X].mod[2]> == 0 && <[Z].mod[2]> == 1:
            - define Offset -1,0,-1
        - define Radius <element[1].mul[2]>
        - define Loc <player.location.add[<[Offset]>].simple.as_location>
        - define cuboid <cuboid[<[Loc].add[<[Radius]>,0,<[Radius]>]>|<[Loc].sub[<[Radius]>,0,<[Radius]>]>]>
        
        - foreach <[Cuboid].blocks.filter[x.mod[2].is[==].to[1]].filter[z.mod[2].is[==].to[0]]> as:Loc:
            - define RLocations li@
            - define BLocations li@
            #-Red Bars
            #@ AirCheck
            - if <[Loc].material.name> == air:
                - define RH 0
            - else if <[Loc].add[0,1,0].material.name> == air:
                - define RH 1
            - else if <[Loc].add[0,2,0].material.name> == air:
                - define RH 2
            - else:
                - define RH 3
            - if <[RH]> != 0:
                - define RLocations <[RLocations].include[<[Loc].add[1,0,1].points_between[<[Loc].add[1,<[RH]>,1]>].distance[0.19]>]>
                - define RLocations <[RLocations].include[<[Loc].add[1,0,0].points_between[<[Loc].add[1,<[RH]>,0]>].distance[0.19]>]>
                - define RLocations <[RLocations].include[<[Loc].add[0,0,1].points_between[<[Loc].add[0,<[RH]>,1]>].distance[0.19]>]>
    #        - define L1 <list[0,0,0|0,0,0|1,0,0|0,0,1|1,0,0|0,0,1|1.99,0,0|0,0,1.99]>
    #        - define L2 <list[1,0,0|0,0,1|1,0,1|1,0,1|1.99,0,0|0,0,1.99|1.99,0,1.99|1.99,0,1.99]>
    #        - repeat 4:
    #            - define RLoc <[Loc].add[<[L1].get[<[value]>]>].points_between[<[loc].add[<[L2].get[<[Value]>]>]>].distance[0.19].parse[add[0,<[RH]>,0]]>
    #        - repeat 4:
    #            - define BLoc <[Loc].add[<[L1].get[<[value].add[4]>]>].points_between[<[loc].add[<[L2].get[<[Value].add[4]>]>]>].distance[0.19]>
    #        - define RLocations <[RLocations].include[<[RLoc]>]>
    #        - define BLocations <[BLocations].include[<[BLoc]>]>
    #        - run Tile_indicator_While instantly def:<[RLocations].escaped>|<[BLocations].escaped>
            #@ top
            - define RLoc1 <[Loc].add[0,0,0].points_between[<[Loc].add[1,0,0]>].distance[0.19].parse[add[0,<[RH]>,0]]>
            #@ side
            - define RLoc2 <[Loc].add[0,0,0].points_between[<[Loc].add[0,0,1]>].distance[0.19].parse[add[0,<[RH]>,0]]>
            #@ top mid
            - define RLoc3 <[Loc].add[1,0,0].points_between[<[Loc].add[1,0,1]>].distance[0.19].parse[add[0,<[RH]>,0]]>
            #@ side mid
            - define RLoc4 <[Loc].add[0,0,1].points_between[<[Loc].add[1,0,1]>].distance[0.19].parse[add[0,<[RH]>,0]]>
            #-Blue Bars
            #@ top
            - define BLoc1 <[Loc].add[1,0,0].points_between[<[Loc].add[1.99,0,0]>].distance[0.19]>
            #@ side
            - define BLoc2 <[Loc].add[0,0,1].points_between[<[Loc].add[0,0,1.99]>].distance[0.19]>
            #@ top mid
            - define BLoc3 <[Loc].add[1.99,0,0].points_between[<[Loc].add[1.99,0,1.99]>].distance[0.19]>
            #@ side mid
            - define BLoc4 <[Loc].add[0,0,1.99].points_between[<[Loc].add[1.99,0,1.99]>].distance[0.19]>
            - repeat 4:
                #@ red bars
                - define RLocations <[RLocations].include[<[RLoc<[Value]>]>]>
                #@ blue bars
                - define BLocations <[BLocations].include[<[BLoc<[Value]>]>]>
    #
    #
            - run Tile_indicator_While instantly def:<[RLocations].escaped>|<[BLocations].escaped>
