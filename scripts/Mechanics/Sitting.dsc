Player_Sitting:
    type: world
    debug: false
    events:
        on player right clicks *stairs:
            - if <player.has_flag[SitDelay]> || <player.has_flag[Essentials.Chair]> || <player.is_sneaking>:
                - stop
            - flag player SitDelay duration:10t

            - define Direction <context.location.material.direction>
            - define Directions <list[EAST/90|SOUTH/180|WEST/270|NORTH/360]>
            - define Location <list[NORTH/0.5,-1.25,0.75|SOUTH/0.5,-1.25,0.25|EAST/0.25,-1.25,0.5|WEST/0.75,-1.25,0.5]>

            - spawn armor_stand[gravity=false;visible=false] <player.location.cursor_on.add[<[Location].map_get[<[Direction]>]>].with_yaw[<[Directions].map_get[<[Direction]>]>]> save:Seat
            - define Chair <entry[Seat].spawned_entities.get[1]>
            - wait 1t
            - mount <player>|<[Chair]>
            - flag <player> Essentials.Chair:<[Chair]> duration:10s
        on player steers entity:
            - if <context.dismount>:
                - remove <player.flag[Essentials.Chair]>
                - flag <player> Essentials.Chair:!
                - teleport <player> <player.location.add[0,1,0]>
