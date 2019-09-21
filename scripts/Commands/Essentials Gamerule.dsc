Gamerule_Command:
    type: command
    name: gamerule
    debug: true
    description: Adjusts gamerules for this world.
    use: "<proc[colorize].context[/gamerule (<&lt>GameRuleName<&gt> <&lt>Value<&gt>) |yellow]>"
    tab complete:
        - if <context.args.size||0> == 0:
            - determine <script[GameRule].list_keys.exclude[Type]>
        - else if <context.args.size> == 1 && !<context.raw_args.ends_with[<&sp>]>:
            - determine <script[GameRule].list_keys.exclude[Type].filter[starts_with[<context.args.get[1]>]]>
    script:
        - if <context.args.get[1]||null> == null:
            - foreach <script[GameRule].list_keys.exclude[Type]> as:GameRule:
                - define Display <proc[Colorize].context[<[GameRule]>|Yellow]>
                - define Lore:->:<&e><proc[LineWrap].context[<script[GameRule].yaml_key[<[GameRule]>.Description]>|40]>
                - if <script[GameRule].yaml_key[<[GameRule]>.Type]> == Boolean:
                    - if <player.world.gamerule[<[GameRule]>]>:
                        - define Item <item[Green_Stained_Glass_pane
                        - define Lore:->:<&6>V<&e>alue<&6>: <&2>T<&a>RUE
                    - else:
                        - define Item <item[Red_Stained_Glass_pane]
                        - define Lore:->:<&6>V<&e>alue<&6>: <&4>F<&c>ALSE
                - else:
                    - define Item <item[Yellow_Stained_Glass_pane]>
                    - define Lore:->:"Current Value: <proc[Colorize].context[Value: <player.world.gamerule[<[GameRule]>]>|yellow]>"
                - define Lore:->:"<proc[Colorize].context[Default Value: <script[GameRule].yaml_key[<[GameRule]>.Default]>|yellow]>"
                - define ItemList:->:<[Item]>
            - define item i@<[Item]>[display=<[Display]>;lore=<[Lore]>]
            - define Title "<&2>GameRule Editor"
            - note "in@generic[title=<[title]>;size=36]" as:<world.name>GameRules
            - inventory set d:<world.name>GameRules o:<[ItemList]>
            - inventory open d:<world.name>GameRules
        - else if <script[GameRule].list_keys.contains[<context.args.get[1]>]>:
            - if <context.args.get[2||null> != null:
                - if <context.args.get[2].is_integer> && <script[GameRule].yaml_key[Type]> == Int:
                    - gamerule <player.world> <context.args.get[1]> <context.args.get[2]>
                - else if <list[True|False].contains[<context.args.get[2]>]>:
                    - gamerule <player.world> <context.args.get[1]> <context.args.get[2]>
                - else:
                    - define Reason "Invalid Value: <context.args.get[2]>"
                    - inject Command_Error
            - else:
                - define Reason "You must type a [<script[GameRule].yaml_key[Type]>] value for the <[Gamerule]> gamerule."
                - inject Command_Error
        - else:
            - define Reason "<context.args.get[1]> is not a real gamerule."
            - inject Command_Error


GameRule:
    type: yaml data
    announceAdvancements:
        description: "Whether advancements should be announced in chat"
        Type: Boolean
        Default: true
    commandBlockOutput:
        Description: "Whether command blocks should notify admins when they perform commands"
        Default: true
        Type: Boolean
    disableElytraMovementCheck:
        Description: "Whether the server should skip checking player speed when the player is wearing elytra. Often helps with jittering due to lag in multiplayer, but may also be used to travel unfairly long distances in survival mode (cheating)."
        Default: false
        Type: Boolean
    disableRaids:
        Description: "Whether raids are disabled."
        Default: false
        Type: Boolean
    doDaylightCycle:
        Description: "Whether the day-night cycle and moon phases progress"
        Default: true
        Type: Boolean
    doEntityDrops:
        Description: "Whether entities that are not mobs should have drops"
        Default: true
        Type: Boolean
    doFireTick:
        Description: "Whether fire should spread and naturally extinguish"
        Default: true
        Type: boolean
    doLimitedCrafting:
        Description: "Whether players should be able to craft only those recipes that they've unlocked first"
        Default: false
        Type: boolean
    doMobLoot:
        Description: "Whether mobs should drop items"
        Default: true
        Type: boolean
    doMobSpawning:
        Description: "Whether mobs should naturally spawn. Does not affect monster spawners."
        Default: true
        Type: boolean
    doTileDrops:
        Description: "Whether blocks should have drops"
        Default: true
        Type: boolean
    doWeatherCycle:
        Description: "Whether the weather can change"
        Default: true
        Type: boolean
    keepInventory:
        Description: "Whether the player should keep items in their inventory after death"
        Default: false
        Type: boolean
    logAdminCommands:
        Description: "Whether to log admin commands to server log"
        Default: true
        Type: boolean
    mobGriefing:
        Description: "Whether creepers, zombies, endermen, ghasts, withers, ender dragons, rabbits, sheep, villagers, and snow golems should be able to change blocks and whether mobs can pick up items"
        Default: true
        Type: boolean
    naturalRegeneration:
        Description: "Whether the player can regenerate health naturally if their hunger is full enough (doesn't affect external healing, such as golden apples, the Regeneration effect, etc.)"
        Default: true
        Type: boolean
    reducedDebugInfo:
        Description: "Whether the debug screen shows all or reduced information; and whether the effects of F3+B (entity hitboxes) and F3+G (chunk boundaries) are shown."
        Default: false
        Type: boolean
    sendCommandFeedback:
        Description: "Whether the feedback from commands executed by a player should show up in chat. Also affects the default behavior of whether command blocks store their output text"
        Default: true
        Type: boolean
    showDeathMessages:
        Description: "Whether death messages are put into chat when a player dies. Also affects whether a message is sent to the pet's owner when the pet dies."
        Default: true
        Type: boolean
    spectatorsGenerateChunk:
        Description: "Whether players in spectator mode can generate chunks"
        Default: true
        Type: boolean

    maxCommandChainLength:
        Description: 'Determines the number at which the chain command block acts as a "chain".'
        Default: 65536
        Type: Int
    maxEntityCramming:
        Description: "The maximum number of other pushable entities a mob or player can push, before taking 3 suffocation damage per half-second. Setting to 0 disables the rule. Damage affects survival-mode or adventure-mode players, and all mobs but bats. Pushable entities include non-spectator-mode players, any mob except bats, as well as boats and minecarts."
        Default: 24
        Type: Int
    randomTickSpeed:
        Description: "How often a random block tick occurs (such as plant growth, leaf decay, etc.) per chunk section per game tick. 0 disables random ticks, higher numbers increase random ticks. Setting to a high integer results in high speeds of decay and growth"
        Default: 3
        Type: Int
    spawnRadius:
        Description: "The number of blocks outward from the world spawn coordinates that a player spawns in when first joining a server or when dying without a personal spawnpoint."
        Default: 10
        Type: Int