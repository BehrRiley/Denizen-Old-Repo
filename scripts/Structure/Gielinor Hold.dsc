Gielinor_Hold_Handler:
    type: world
    debug: false
    events:
        on player clicks Combat_Slot|Stat_Slot|Quest_Journal|Equipment_Slot|Prayer_Slot|Magic_Spellbook|Settings_Slot in inventory:
            - if <context.inventory> == <player.inventory>:
                - determine cancelled
        on player drops Combat_Slot|Stat_Slot|Quest_Journal|Equipment_Slot|Prayer_Slot|Magic_Spellbook|Settings_Slot:
            - determine cancelled