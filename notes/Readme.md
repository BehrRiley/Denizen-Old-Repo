# :taco: Table of Contents :taco:
- [Scripts](../scripts/)
    - [x] Complete / Consistent
    - [ ] Revisit
    - [Quests](../scripts/Quests) | Quest Handling scripts
        - [ ] [Shield of Arrav](../scripts/NPCs/Shield%20of%20Arrav.dsc)
    - [commands](../scripts/commands)
        - [x] [NpcSkinLoader](../scripts/NPCs/NpcSkinLoader.dsc) | loads NPC skin from URL
        - [x] [NpcSkinSaver](../scripts/NPCs/NpcSkinSaver.dsc) | saving NPC skins for assignment loading, prevents re-loading consistently
    - [data](../scripts/data)
        - [x] [formatting](../scripts/NPCs/formatting.dsc) | all formatting scripts
        - [ ] [inventories](../scripts/NPCs/inventories.dsc) | all inventory scripts - major rewrite for magic spellbooks
        - [ ] [iQUOP](../scripts/NPCs/iQUOP.dsc) | custom item texture procedure - major rewrite
        - [x] [items](../scripts/NPCs/items.dsc) | all custom item scripts
    - [mechanics](../scripts/mechanics)
        - [x] [Banking](../scripts/NPCs/Banking.dsc) | Player & Admin Banking System
        - [ ] [Combat](../scripts/NPCs/Combat.dsc) | Combat Algorithm - Major Rewrite
        - [x] [DialogueOptionBuilders](../scripts/NPCs/DialogueOptionBuilders.dsc)
        - [x] [Experience](../scripts/NPCs/Experience.dsc) | Skill Experience Algorithm
        - [ ] [Thieving](../scripts/NPCs/Thieving.dsc) | Theiving skill - major rewrite
    - [NPCs](../scripts/NPCs)
        - [x] [Template](../scripts/NPCs/!Template.dsc)
        - [x] [Hans](../scripts/NPCs/Hans.dsc)
        - [ ] [Baraek](../scripts/NPCs/Baraek.dsc)
        - [ ] [Charlie_The_Tramp](../scripts/NPCs/Charlie_The_Tramp.dsc)
        - [ ] [Johnny_The_Beard](../scripts/NPCs/Johnny_The_Beard.dsc)
        - [ ] [Katrine](../scripts/NPCs/Katrine.dsc)
        - [ ] [Reldo](../scripts/NPCs/Reldo.dsc)
        - [ ] [Straven](../scripts/NPCs/Straven.dsc)
        - [ ] [Weaponmaster](../scripts/NPCs/Weaponmaster.dsc)

## Project Ideas
### Procedurally Generating Dungeons

**Concept**:

####Concept Arts

#####Generate Main Layout:

![Dungeoneering1](https://cdn.discordapp.com/attachments/547552615450411011/556603700836302863/entry004-map.png)

#####Convert to Tree layout for easier recursion 

![Dungeoneering2](https://cdn.discordapp.com/attachments/547552615450411011/556603770721533962/entry004-tree.png)

#####Generate place keys blocking off final or exteeding rooms

![Dungeoneering3](https://cdn.discordapp.com/attachments/547552615450411011/556603821346783232/entry004-tree2.png)

#####Recursively place keys blocking off further rooms

![Dungeoneering4](https://cdn.discordapp.com/attachments/547552615450411011/556603887176515609/entry004-tree3.png)

#####Generate room based on final recursion

![Dungeoneering5](https://cdn.discordapp.com/attachments/547552615450411011/556603905018953748/entry004-map2.png)

Concept arts by Sean Howard