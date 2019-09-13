r:
    type: command
    name: r
    aliases:
        - /r
    script:
        - reload

rh:
    type: world
    events:
        on reload scripts:
            - if <context.haderror>:
                - announce "<&c>Error Reloading Scripts"