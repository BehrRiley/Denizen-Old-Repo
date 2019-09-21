r:
    type: command
    name: r
    debug: false
    aliases:
        - /r
    script:
        - if <player.flag[behrry.essentials.rank]||5> > 2 && !<context.server>:
          - narrate "<proc[colorize].context[Nothing interesting happens.|yellow]>"
          - stop
        - reload

rh:
    type: world
    debug: false
    events:
        on reload scripts:
            - if <context.haderror>:
                - announce "<&c>Reload Error"
            - else:
                - announce "<&a>Reloaded"