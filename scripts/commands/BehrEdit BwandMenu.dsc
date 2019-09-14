# | ███████████████████████████████████████████████████████████
# % ██    //WandMenu Command for opening BehrEdit menu options
# | ██
# % ██  [ Command ] ██
# $ ██  [ TO-DO   ] ██ | oh god
WandMenu_Command:
  type: command
  name: /wandmenu
  debug: false
  description: Manually opens the BehrEdit options menu
  aliases:
    - /wandmenu
    - /wm
    - /menu
    - /options
  script:
    - if <context.args.get[1]||null> == null:
      - inventory open d:in@BwandMenu