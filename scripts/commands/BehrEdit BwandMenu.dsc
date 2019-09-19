# | ███████████████████████████████████████████████████████████
# % ██    //WandMenu Command for opening BehrEdit menu options
# | ██
# % ██  [ Command ] ██
# $ ██  [ TO-DO   ] ██ | oh god
WandMenu_Command:
  type: command
  name: wandmenu
  debug: false
  description: Manually opens the BehrEdit options menu
  aliases:
    - /wm
    - /menu
    - /options
  script:
    - if <context.args.get[1]||null> == null:
      - inventory open d:in@BwandMenu
BW_Command:
  type: command
  name: bw
  debug: false
  description: Click triggers for items in Behredit Wand Menu
  script:
    - choose <context.args.get[1]>:
      - case "mode":
        - inject Mode_Command instantly
      - case "selection":
        - inject Selection_Command instantly
      - case "monitor":
        - inject Monitor_Command instantly
        
Mode_Command:
  type: command
  name: mode
  debug: false
  description: Changes Selection Mode for BehrEdit
  aliases:
    - /mode
  script:
    - if <list[Cuboid|ExpandingCuboid|IrregularPolygon|Filler].contains[<context.args.get[2]>]>:
      - flag <player> BehrEdit.Selection.Mode:<context.args.get[2]>
      - narrate "<proc[Colorize].context[Selection Mode: <context.args.get[2]>|yellow]>"
Selection_Command:
  type: command
  name: selection
  debug: false
  description: Changes Selection Mode for BehrEdit
  aliases:
    - /selection
  script:
    - if <context.args.get[1]> == clear:
      - flag player Behredit.Position.1:!
      - flag player Behredit.Position.2:!
      - flag player Behredit.Position:!
      - flag player Behredit.Position.IrregularPoly:!
      - narrate "<proc[Colorize].context[Positions Reset.|yellow]>"

Monitor_Command:
  type: command
  name: monitor
  debug: false
  description: Turns BehrEdit Selection monitoring.
  aliases:
    - /monitor
  script:
    - if <player.has_flag[Behredit.Monitor]>:
      - flag player Behredit.Monitor:!
      - narrate "<&6>S<&e>election <&6>M<&e>onitor <&6>D<&e>eactivated."
    - else:
      - flag player Behredit.Monitor
      - narrate "<&6>S<&e>election <&6>M<&e>onitor <&6>A<&e>ctivated."
      - run BehrEdit_Monitor_Task instantly
