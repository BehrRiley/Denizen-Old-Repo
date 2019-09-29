QuestJournal_Command:
    type: command
    name: questjournal
    aliases:
        - journal
    debug: false
    script:
        - if <context.alias||null> == journal && <context.args.get[1]||null> != quest:
            - stop
        - else if <context.alias||null> == questjournal && <context.args.get[1]||null> != null:
            - stop
        - else if <contxt.args.size> > 1:
            - if <context.args.get[2]> == help && <context.args.get[3]||null> != null:
                - inject HAAAAALPPPP instantly
            - else:
                - stop
        - else:
            - inject Quest_Journal_Task Instantly

Quest_Journal_Task:
    type: task
    debug: false
    speed: 0
    script:
        - define Author "Bear"
        - define Title "Title Thingo"

        - define Hover "<proc[Colorize].context[Click for Help|yellow]>"
        - define Text "<&6><&l>[<&3><&l> Quest Points<&6><&l>: <&2><player.flag[Quest.Points].as_element.pad_left[3].with[0]> <&6><&l>]"
        - define Command "ØPERATOR MyseriousKebab quest help"
        - define Header:|:<proc[MsgCmdB].context[<[Hover]>|<[Text]>|<[Command]>]>|<&f>

        #- foreach <script[Procedural_Quest_Journal].yaml_key[Quests]> as:Quest:
            #- define Flag "Quest.<[Quest].replace[<&sp>].with[].replace['].with[]>.Status"
        - foreach <yaml[QuestData].read[QuestList].parse[replace[.].with[]]> as:Quest:
            - if <yaml[<player>].read[QuestData.<[Quest]>.Status]||null> == null:
                - yaml id:<player> set QuestData.<[Quest]>.Status:NotStarted
            #- if !<player.has_flag[<[Flag]>]>:
            #    - flag <player> <[Flag]>:NotStarted
            #- choose <player.flag[<[Flag]>]>:
            - choose <yaml[<player>].read[QuestData.<[Quest]>.Status]>:
                - case "Complete":
                    - define QuestItem "<proc[MsgCmdB].context[<proc[Colorize].context[Read Journal:|yellow]><&nl><proc[Colorize].context[<[Quest]>|green]>|<&a><[Quest]>|ØPERATOR MyseriousKebab quest Complete <[Quest]>]>"
                - case "InProgress":
                    - define QuestItem "<proc[MsgCmdB].context[<proc[Colorize].context[Read Journal:|yellow]><&nl><proc[Colorize].context[<[Quest]>|yellow]>|<&e><[Quest]>|ØPERATOR MyseriousKebab quest InProgress <[Quest]>]>"
                - default:
                    - define QuestItem "<proc[MsgCmdB].context[<proc[Colorize].context[Read Journal:|yellow]><&nl><proc[Colorize].context[<[Quest]>|red]>|<&4><[Quest]>|ØPERATOR MyseriousKebab quest NotStarted <[Quest]>]>"
            - define QuestList:->:<[QuestItem]>
        - yaml id:<player> savefile:data/pData/<player.uuid>.yml

        - if <[QuestList].size> > 10:
            - repeat <[QuestList].size.div[10].round_up>:
                - define Math <[value].mul[10].sub[9]>
                - define QuestList<[Value]>:<[QuestList].get[<[Math]>].to[<[Math].add[9]>]>
                - define ContentList:->:<[Header].include[<[QuestList<[Value]>]>].separated_by[<&nl>]>
        - else:
            - define ContentList:<[Header].include[<[QuestList]>].separated_by[<&nl>]>
            
        - adjust <player> show_book:i@written_book[book=author|<[Author]>|title|<[Title]>|pages|<[ContentList].separated_by[|].unescaped>]



Quest_Journal_Help_Task:
    type: task
    debug: true
    script:
        - define Author "Bear"
        - define Title "Title Thingo"

        - define Hover "<proc[Colorize].context[Return to Quest Journal|yellow]>"
        - define Text "<&6><&e>--- <&3><&l>Quest Help <&e>---<&6>"
        - define Command "ØPERATOR MyseriousKebab quest main"
        - define Header:|:<proc[MsgCmdB].context[<[Hover]>|<[Text]>|<[Command]>]>|<&f>

        - foreach <yaml[QuestData].list_keys[QuestHelp]> as:Page:
            - define Content:<yaml[QuestData].read[QuestHelp.<[Page]>].parsed>
            - define ContentList:->:<[Header].include[<[Content]>].separated_by[<&nl>]>
        - adjust <player> show_book:i@written_book[book=author|<[Author]>|title|<[Title]>|pages|<[ContentList].separated_by[|]>]



Tutorial_Start_Handler:
    type: world
    events:
        on player right clicks with Quest_Journal:
            - determine passively cancelled
            - if <yaml[<[player>].read[QuestData.Points]||null> == null:
                - yaml id:<player> set QuestData.Points:0
                - yaml id:<player> savefile:data/pData/<player.uuid>.yml
            - inject Quest_Journal_Task Instantly
        on ØPERATOR command:
            - determine passively fulfilled
            - if <context.args.get[1]||null> != MyseriousKebab || <context.args.size> < 2:
                - stop
            - choose <context.args.get[2]>:
                - case quest:
                    - choose <context.args.get[3]>:
                        - case "help":
                            - Inject Quest_Journal_Help_Task Instantly
                        - case "main":
                            - inject Quest_Journal_Task Instantly
                        - case "NotStarted":
                            - define QuestName "<context.raw_args.after[NotStarted ]>"
                            - inject Quest_Journal_Start_Entry_Task Instantly
                        - default:
                            - stop
                - default:
                    - stop

Procedural_Quest_Journal:
    type: yaml data
    Quests:
        - "Tutorial Island"

        - "Black Knights' Fortresss"
        - "Cook's Assistant"
        - "The Corsair Curse"
        - "Demon Slayer"
        - "Doric's Quest"
        - "Dragon Slayer"
        - "Ernest the Chicken"
        - "Goblin Diplomacy"
        - "Imp Catcher"

        - "The Knight's Sword"
        - "Misthalin Mystery"
        - "Pirate's Treasure"
        - "Price Ali Rescue"
        - "The Restless Ghost"
        - "Romeo and Juliet"
        - "Rune Mysteries"
        - "Sheep Shearer"
        - "Shield of Arrav"
        - "Vampire Slayer"

        - "Witch's Potion"
        - "X Marks the Spot"
        - "Animal Magnetism"
        - "Another Slice of H.A.M."
        - "Between a Rock..."
        - "Big Chompy Bird Hunting"
        - "Biohazard"
        - "Bone Voyage"
        - "Cabin Fever"
        - "Client of Kourend"

        - "Clock Tower"
        - "Cold War"
        - "Contact!"
        - "Creature of Fenkenstrain"
        - "Darkness of Hallowvale"
        - "Death Plateau"
        - "Death to the Dorgeshuun"
        - "The Depths of Despair"
        - "Desert Treasure"
        - ""

        - "Devious Minds"
        - "The Dig Site"
        - "Dragon Slayer II"
        - "Dream Mentor"
        - "Druidic Ritual"
        - "Dwarf Cannon"
        - "Eadgar's Ruse"
        - "Eagles' Peak"
        - "Elemental Workshop I"
        - "Elemental Workshop II"

        - "Enakhra's Lament"
        - "Enlightened Journey"
        - "The Eyes of Glouphrie"
        - "Fairytale I - Growing Pains"
        - "Fairytale II - Cure a Queen"
        - "Family Crest"
        - "The Feud"
        - "Fight Arena"
        - "Fishing Contest"
        - "Forgettable Tale..."

        - "The Fremennik Isles"
        - "The Fremennik Trials"
        - "Garden of Tranquillity"
        - "Gertrude's Cat"
        - "Ghosts Ahoy"
        - "The Giant Dwarf"
        - "The Golem"
        - "The Grand Tree"
        - "The Great Brain Robbery"
        - "Grim Tales"

        - "The Hand in the Sand"
        - "Haunted Mine"
        - "Hazeel Cult"
        - "Heroes' Quest"
        - "Holy Grail"
        - "Horror from the Deep"
        - "Icthlarin's Little Helper"
        - "In Aid of the Myreque"
        - "In Search of the Myreque"
        - "Jungle Potion"

        - "King's Ransom"
        - "Legends' Quest"
        - "Lost City"
        - "The Lost Tribe"
        - "Lunar Diplomacy"
        - "Making Friends with My Arm"
        - "Making History"
        - "Merlin's Crystal"
        - "Monk's Friend"
        - "Monkey Madness I"

        - "Monkey Madness II"
        - "Mountain Daughter"
        - "Mourning's Ends Part I"
        - "Mourning's Ends Part II"
        - "Murder Mystery"
        - "My Arm's Big Adventure"
        - "Nature Spirit"
        - "Observatory Quest"
        - "Olaf's Quest"
        - "One Small Favour"

        - "Plague City"
        - "Priest in Peril"
        - "The Queen of Thieves"
        - "Rag and Bone Man"
        - "Rag and Bone Man II"
        - "Ratcatchers"
        - "Recipe for Disaster"
        #- "Recipe for Disaster/Another Cook's Quest"
        #- "Recipe for Disaster/Defeating the Culinaromancer"
        #- "Recipe for Disaster/Freeing Evil Dave"
        #- "Recipe for Disaster/Freeing King Awowogei"
        #- "Recipe for Disaster/Freeing Pirate Pete"
        #- "Recipe for Disaster/Freeing Sir Amik Varze"
        #- "Recipe for Disaster/Freeing Skrach Uglogwee"
        #- "Recipe for Disaster/Freeing the Goblin generals"
        #- "Recipe for Disaster/Freeing the Lumbridge Guide"
        #- "Recipe for Disaster/Freeing the Mountain Dwarf"
        #- "Recipe for Disaster/Full guide"
        - "Recruitment Drive"
        - "Regicide"
        - "Roving Elves"

        - "Royal Trouble"
        - "Rum Deal"
        - "Scorpion Catcher"
        - "Sea Slug"
        - "Shades of Mort'ton"
        - "Shadow of the Storm"
        - "Sheep Herder"
        - "Shilo Village"
        - "The Slug Menace"
        - "A Soul's Bane"

        - "Spirits of the Elid"
        - "Swan Song"
        - "Tai Bwo Wannai Trio"
        - "A Tail of Two Cats"
        - "Tale of the Righteous"
        - "A Taste of Hope"
        - "Tears of Guthix (quest)"
        - "Temple of Ikov"
        - "Throne of Miscellania"
        - "The Tourist Trap"

        - "Tower of Life"
        - "Tree Gnome Village"
        - "Tribal Totem"
        - "Troll Romance"
        - "Troll Stronghold"
        - "Underground Pass"
        - "Wanted!"
        - "Watchtower"
        - "Waterfall Quest"
        - "What Lies Below"

        - "Witch's House"
        - "Zogre Flesh Eaters"
    QuestHelp:
        1:
            - "<&6><&l>---<&8><&l>Progress 1.1<&6><&l>---<&8>"
            - "<&r>"
            - "The list is coloured-coded based on the progress made in each quest:"
            - ""
            - "- <&e>Yellow <&r>(In progress)"
            - "- <&a>Green <&r>(Complete)"
            - "- <&4>Red <&r>(Not started)"
        2:
            - "<&6><&l>---<&8><&l>Difficulty 1.2<&6><&l>---<&8>"
            - ""
            - "The list is sorted based on the difficulty of each quest:"
            - ""
            - "- Novice"
            - "- Intermediate"
            - "- Experienced"
            - "- Master"
            - "- Special"
        3:
            - "<&6><&l>---<&8><&l>Journal 1.3.1<&6><&l>---<&8>"
            - ""
            - "Clicking on a quest name shows a screen with:"
            - ""
            - "- How to start the quest (if the player has not started it)"
            - "- How to progress further in the quest"
        4:
            - "<&6><&l>---<&8><&l>Journal 1.3.2<&6><&l>---<&8>"
            - ""
            - "- What the player has already done in the quest"
            - ""
            - "Clicking on a quest that has been completed shows a screen with:"
            - ""
            - "- What the player did during the quest"
        5:
            - "<&6><&l>---<&8><&l>Journal 1.3.3<&6><&l>---<&8>"
            - ""
            - "- The reward(s) obtained"
            - ""
            - "<&6><&l>-<&8><&l>Quest Points 1.4<&6><&l>-<&8>"
            - "At the top of the journal, the number of quest points obtained is displayed."








Quest_Journal_Start_Entry_Task:
    type: task
    script:
        - define Author "Bear"
        - define Title "Title Thingo"

        #- define Hover "<proc[Colorize].context[Return to Quest Journal|yellow]>"
        #- define Text "<&c><[QuestName]><&r>"
        #- define Command "ØPERATOR MyseriousKebab quest main"
        #- define Header:|:<proc[MsgCmdB].context[<[Hover]>|<[Text]>|<[Command]>]>|<&f>
        - define Header:|:Hi|Hello

        - define Content <[Header].include[<yaml[QuestData].read[Quests.<[QuestName]>.start]>]>
        - adjust <player> show_book:i@written_book[book=author|<[Author]>|title|<[Title]>|pages|<[Content].separated_by[<&nl>]>]