r:
    type: command
    name: r
    aliases:
        - /r
    script:
        - if <player.flag[behrry.essentials.rank]> > 2:
          - narrate "<proc[colorize].context[Nothing interesting happens.|yellow]>"
          - stop
        - reload

rh:
    type: world
    events:
        on reload scripts:
            - if <context.haderror>:
                - announce "<&c>Error Reloading Scripts"
            - else:
                - announce "<&a>Reloaded"