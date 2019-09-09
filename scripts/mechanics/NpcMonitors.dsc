# | ███████████████████████████████████████████████████████████
# % ██   Temporary Test | Interact Scripts
# | ██
# % ██   This task determines if the player has a cooldown flag
# | ██
# % ██   Hard-codes the step: - define Step Normal [*30][*Hans]
# | ██
# % ██   Returns Step's valid trigger scripts and builds the
# % ██   <[Trigger_List]> from NPCName_Interact.Triggers:
# % ██   Triggers:
# % ██     MiscChatter1: who
# % ██     MiscChatter2: kill
# % ██     WhereAmI: where
# % ██     TimeStamp: how
# | ██
# % ██   Builds the <[Trigger_Blacklist]> matching the list, removing
# % ██   them from the <[Trigger_List]> after removing the corresponding
# % ██   index from the <[Options_List]>:
# % ██   - define Options_List "<list[I'm looking for whoever is in charge
# % ██      of this place.|I have come to kill everyone in this castle!|I
# % ██      don't know. I'm lost. Where am i?|Can you tell me how long I've
# % ██      been here?]>"
# | ██
# % ██ [ Assignment Script ] ██
OptionCooldown:
    type: task
    debug: false
    script:
        - define SubStep "<script[<queue.script.name>_Interact].list_keys[steps.<[Step]>.chat trigger].exclude[Greeting|Blacklist]>"
        - define Trigger_List li@
        - define Trigger_Blacklist li@
        - foreach <[SubStep]> as:Trigger:
            - define Trigger_List <[Trigger_List].include[<script[<queue.script>_interact].yaml_key[Triggers.<[Trigger]>]>]>
            - if <player.has_flag[option_cooldown.<[Trigger]>]>:
                - define Trigger_Blacklist <[Trigger_Blacklist].include[<script[<queue.script>_interact].yaml_key[Triggers.<[Trigger]>]>]>
        - define Option_Blacklist li@
        - foreach <[Trigger_Blacklist]>:
            - define Option_Blacklist <[Option_Blacklist].include[<[Trigger_List].find[<[value]>]>]>
        - define Trigger_List <[Trigger_List].exclude[<[Trigger_Blacklist]>]>
        - define Options_List <[Options_List].remove[<[Option_Blacklist]>]>

