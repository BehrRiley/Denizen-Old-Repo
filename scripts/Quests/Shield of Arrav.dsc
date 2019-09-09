# | ███████████████████████████████████████████████████████████
# % ██   Quest Event Handlers
# | ██
# % ██ [ Searching Bookshelves ] ██
#SoAQuestHandler:
#  type: world
#  debug: false
#  events:
#    on player clicks block in EmptyBookshelf:
#      - narrate "You search the books..."
#      - wait 2s
#      - narrate "You find nothing of interest to you."
#    on player clicks block in SoAQuestBookshelf:
#      - narrate "You search the books..."
#      - wait 2s
#      - narrate "Aha! 'The Shield Of Arrav'! Exactly what I was looking for."
#      - wait 1s
#      - narrate "You take the book from the bookcase."
#      - give i@SoAQuestBook
#    on player clicks with SoAQuestBook:
#      - if <context.click_type.contains[RIGHT]>:
#        - flag player Quest.SoA.Stage:2
#        #%THIS NEEDS TESTING V %#
#    on player clicks block in SoADoors:
#      - if <context.location> == l@#,#,#,Runescape:
#        # - if NOT in Black Arm Gang
#            # % % % % % CONSIDER CUTTING THIS ENTIRE CHUNK REPLACE WITH INJECT % % % % % % % % % % %
#        - if <player.flag[quest.SoA.Gang]> != "Pheonix":
#          - determine passively cancelled
#          - flag player interacting_npc:Straven
#        # - if accepted in Black Arm gang
#        - else if <player.flag[quest.SoA.Gang]> == "Pheonix":
#          - stop
#        # - if accepted Pheonix Gang
#        - else if <player.flag[Quest.SoA.Gang]> == "BlackArm":
#          - narrate format:StravenNPC "<s@straven.yaml_key[d30]>"
#          - wait 2s
#          # - if hasnt finished quest
#          # % % % % % % % % % % % % % % % % % %LAST STAGE NUMBER% % % % % % % % % % % % % % % % % %
#          - if <player.flag[Quest.SoA.Gang]> < LASTSTAGENUMBERHERE:
#          #>
#            - narrate format:StravenNPC "<s@straven.yaml_key[d31]>"
#            - wait 3s
#            - narrate format:StravenNPC "<s@straven.yaml_key[d32]>"
#            - wait 5s
#            # % % % % % % % % % % % % % % % % % % Yes/No Switch Allegiance% % % % % % % % % % % % %
#            # - run Straven path:opt_loop def:o|Straven instantly
#          - stop
#        - else:
#          - narrate format:StravenNPC "<s@straven.yaml_key[d1]>"
#          - wait 2s
#          # - if player knows who they are
#          - if <player.flag[Quest.SoA.Stage]> < 3:
#            # >
#            # %  % % % % % % % % % % % % % % % % % option one% % % % % % % % % % % % % % % % % % % %
#            # - run Straven path:opt_loop def:o1|Straven instantly
#          # | if doesnt
#          - else if <player.flag[Quest.SoA.Stage]> == 3:
#            # % % % % % % % % % % % % % % % % % % option two% % % % % % % % % % % % % % % % % % % %
#            # - run Straven path:opt_loop def:o2|Straven instantly
#            # % % % % % CONSIDER CUTTING THIS ENTIRE CHUNK REPLACE WITH INJECT % % % % % % % % % % %

# | ███████████████████████████████████████████████████████████
# % ██   Quest Items
# | ██
# % ██ [ Searching Bookshelves ] ██
SoAQuestBook:
  type: book
  title: Shield of Arrav
  author: A. R. Wright.
  signed: true
  # - Each -line in the text section represents an entire page.
  # - To create a newline, use the tag <n>. To create a paragraph, use <p>.
  text:
    - Arrav is probably the best known hero of the 4th Age. <p>Many legends are told of his heroics. One surviving artefact from the 4th Age is a fabulous shield. This shield is believed to have once belonged to Arrav and is now indeed known as the Shield of Arrav.
    - For over 150 years it was the prize piece in the royal museum of Varrock. However, in the year 143 of the fifth age a gang of thieves called the Phoenix Gang broke into the museum and stole the shield in a daring raid.
    - As a result, the current ruler, King Roald, put a 1200 gold bounty (a massive sum of money in those days) on the return of the shield, hoping that one of the culprits would betray his fellows out of greed.
    - This tactic did not work however, and the thieves who stole the shield have since gone on to become the most powerful crime gang in Varrock, despite making an enemy of the Royal Family many years ago.
