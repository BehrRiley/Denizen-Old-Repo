Trigger_Option_builder:
  type: task
  debug: false
  script: 
    - foreach <[Options_List]>:
      - define Message "<&6>[<&a>Click<&6> <&a><[value]>"
      - define SendMessage <[Trigger_List].get[<[loop_index]>]>
      - define Hover "<&6>[<&a>Select<&6>]<&a> <[value]>"
      - narrate format:npc <proc[MsgChat].context[<[Message]>|<[SendMessage]>|<[Hover]>]>
