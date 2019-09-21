################################################################################
#                                                                              #
#                    M e s s a g e   C o n s t r u c t o r                     #
#                              L I B R A R Y                                   #
#                                                                              #
#     A set of utilities to make displaying text pretty, uniform, and easy     #
#                                                                              #
#   Authors: |Anthony|                                                         #
#   Version: 0.5                                                               #
#   dScript Version: 1.0.3-DEV_b691                                            #
#                                                                              #
#   For bleeding-edge code, bug reports, code contributions, and feature       #
#    requests, visit the GitHub project:                                       #
#    - github.com/AnthonyAMC/Public-Denizen-Scripts/blob/master/MessageConstructors.yml
#                                                                              #
#   Has my work helped you in some way? Show your support by clicking the      #
#    Like button.                                                              #
#   Feeling generous? Get me a coffee :D                                       #
#    https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=NPXKHCNMTGSUG
#                                                                              #
#--------------------------------------                                        #
#                                                                              #
#--- About this script                                                         #
#                                                                              #
#                                                                              #
#  This library will be a dependency for nearly all of my scripts. Mainly so   #
#  I don't have to duplicate the code so much, but also because it makes       #
#  development and maintenance easier.                                         #
#                                                                              #
#  Other scripters are free to implement this library in their own scripts.    #
#  Just make sure you credit the author. If you are releasing a script that    #
#  uses this library, be sure to tell your users to install it from here.      #
#  Do not include this library, or parts of it, directly in your public        #
#  scripts.                                                                    #
#                                                                              #
#                                                                              #
################################################################################
#
#  Example Usages:
#
#    - narrate "click <&e><proc[msgUrl].context[<&e>this|google.com/search|<&9>click]><&f> link"
#
#    - narrate "read the <&e><proc[msgCommand].context[<&e>help|help|<&a>click here fool!]><&f> docs"
#
#    - narrate "hover your mouse on the <&e><proc[msgHover].context[<&e>secret|<&6>gold star!]><&f> message"
#
#    - narrate "click <&e><proc[msgChat].context[<&e>yes|yes|Click this]><&f> to make your player say yes in chat"
#
#    - narrate "Give the player a <&e><proc[msgHint].context[<&e>Command|command|Click this]><&f> hint"
#
#    - narrate " <&e><proc[msgSuggest].context[<&e>Suggest|Maybe say this|Click this]><&f> something for your player to type"
#
################################################################################
#
#  Message Constructor Library Version
#
#  Handles Versioning Checks
#
MSG_Version:
  type: version
  author: Anthony
  name: MessageConstructorLibrary
  version: 0.5
  description: A Library for Message Construction
  id: 90
#
#---------------------------------------
#
MCL_Events:
  type: world
  debug: false
  events:
    on system time hourly:
#    - if !<yaml[MCL_config].read[config.stats.useStats]||true>:
#      - queue clear
#
    - if <queue.list> !contains 'q@MCL_UpdateCheck':
      - run locally delay:1t updateCheck 'id:MCL_UpdateCheck'

    on server start:
    - if <queue.list> !contains 'q@MCL_UpdateCheck':
      - run locally delay:1t updateCheck 'id:MCL_UpdateCheck'

    on script reload:
    - if <queue.list> !contains 'q@MCL_UpdateCheck':
      - run locally delay:1t updateCheck 'id:MCL_UpdateCheck'

  updateCheck:
    - ^if !<server.has_flag[MCL.Version.Repo]>:
#      - ~webget "https://raw.githubusercontent.com/AnthonyAMC/Public-Denizen-Scripts/master/versions/MCL.txt" save:page
      - ~webget "https://one.denizenscript.com/denizen/repo/version/<s@MSG_Version.yaml_key[id]>" save:page
      - ^define result '<entry[page].result.trim||unknown>'
      - ^if !<def[result].is[matches].to[number]>:
        - define result 'unknown'
      - ^flag server "MCL.Version.Repo:<def[result]>" d:1h
    - ^define repoVersion '<server.flag[MCL.Version.Repo]||unknown>'
    - ^define currentVersion '<s@MSG_Version.yaml_key[version]>'
    - ^if '<def[repoVersion]>' == 'unknown':
      - run s@msgPrefixed instantly 'def:MCL|<&7>Unable to check for update! <&7><&o><def[currentVersion]><&7> is installed!'
    - else if '<def[repoVersion]>' > '<def[currentVersion]>':
      - run s@msgPrefixed instantly 'def:MCL|<&7>Update from version <&o><def[currentVersion]><&7> to <&o><def[repoVersion]><&7>!'
    - else if '<def[repoVersion]>' != '<def[currentVersion]>':
      - run s@msgPrefixed instantly 'def:MCL|<&7>What happened? You are on version <&o><def[currentVersion]><&7> and the repo says <&o><def[repoVersion]><&7>!'

#
#---------------------------------------
#
################################################################################
#
#
#--------------------------------------
#
#  Message Prefixer
#
# - Pop-Up on hover shows your script title and 'Click for Help'
# - Clicking the prefix runs /<def[title]> help
# - Long messages are automatically linewrapped
#
#  Usage:
#    - run s@msgPrefixed 'def:<def[yourScriptTitle]>|<&c><def[yourMessageHere]>'
#
msgPrefixed:
  type: item
  debug: false
  definitions: title|msg
  material: i@human_skull
  display name: "<&4>     [<&6>---<&4>]"
  lore:
  - <&5>Click for Help
  script:
    - ^define text '<&4>[<&6><def[title]><&4>]'
    - ^if !<player.is_player||false>:
      - announce to_console "<def[text]>  <def[msg]>"
      - goto 'end'

    - ^define icon 'i@human_skull[display_name=<proc[msgCentered].context[19|<def[title]>]>]'
    - ^adjust <def[icon]> 'lore:<&sp>|<&5> Click for Help' save:item
    - ^define hover '{<entry[item].result.json>}'
    - ^define click '/<def[title]> help'
    - ^define button '"text":"<def[text]>","clickEvent":{"action":"run_command","value":"<def[click]>"},"hoverEvent":{"action":"show_item","value":"<def[hover]>"}'
    - ^define spacer '"text":"  "'
    - ^foreach '<proc[lineWrap].context[<parse:<def[msg]>>|<el@val[70].sub[<def[text].length>]>]>':
      - ^execute as_server 'tellraw <player.name> {"text":"","extra":[{<def[button]>},{<def[spacer]>},{"text":"<def[value].unescaped>"}]}'
    - mark 'end'
#
#  END msgPrefixed
#--------------------------------------
#
#  Boxed Message
#
# - Encapsulate your messages in a neat and tidy box format
#   Messages sent through will be linewrapped and given a header and footer
# - Header displays specified script title, page title, and page number(s)
# - Page numbers are clickable to ease navigation
# - Footer can display clickable buttons for your script authors
#   - You must have a valid author item script named <def[script]>_Author_<def[authorname]>
#
# Definitions Explained:
#
#  <def[script]>      - The prefix used to find your authors
#  <def[title]>       - The title to display in the Header
#  <def[subTitle]>    - The subtitle to display in the Header
#  <def[command]>     - The command to run when the page buttons are clicked
#  <def[page]>        - The current page to display
#  <def[pageWidth]>   - How many characters (roughly) to display on one line
#  <def[pageHeight]>  - How many lines in the body of the message should be on one page
#  <def[entries]>     - The complete contents of the document your are working with.
#                  Every entry in the list is displayed on its own line. Long
#                  entries are automatically linewrapped to fit the box message.
#
#  Usage:
#    - run s@msgBoxed 'def:<def[script]>|<def[title]>|<def[subTitle]>|<def[command]>|<def[page]>|<def[pageWidth]>|<def[pageHeight]>|<def[entries]>'
#
msgBoxed:
  type: task
  debug: false
  definitions: script|title|subTitle|command|page|pageWidth|pageHeight
  script:
    - ^define entries '<def[raw_context].split[|].remove[1|2|3|4|5|6|7]>'
    - ^foreach 'li@script|title|subTitle|command|page|pageWidth|pageHeight':
      - define <def[value]> '<def[raw_context].split[|].get[<def[loop_index]>]>'
    - ^define paragraphs '<proc[paragraph].context[<def[pageWidth]>|<def[entries].separated_by[|]>]>'
    - ^if <def[page]> < 1:
      - define page '1'
    - ^define pageInfo '<proc[pagination].context[<def[page]>|<def[pageHeight]>|<def[paragraphs].separated_by[|]>]>'
    - ^define pageTotal '<def[pageInfo].get[2]>'
    - ^if <def[page]> > <def[pageTotal]>:
      - define page '<def[pageTotal]>'
    - ^define lines '<def[pageInfo].get[3].to[<def[pageInfo].size>]>'
    - ^define cList 'li@0/black|1/dark_blue|2/dark_green|3/dark_aqua|4/dark_red|5/dark_purple|6/gold|7/gray|8/dark_gray|9/blue|a/green|b/aqua|c/red|d/light_purple|e/yellow|f/white|k/obfuscated|l/bold|m/strikethrough|n/underline|o/italic|r/reset'

    - ^define i 0
    - ^foreach 'li@title|subTitle':
      - define this '<def[value]>'
      - define thisValue '<def[<def[this]>]>'
      - define clean<def[this]> 'li@'
      - foreach '<def[thisValue].split[ ]>':
        - define i <def[i].add[1]>
        - define word '<def[value]>'
        - if '<def[word]>' == '':
          - define clean<def[this]> '<def[clean<def[this]>].include[<&sp>]>'
          - foreach next
        - if !<def[word].starts_with[<&r><&ss>@<&ss><&chr[260f]>]>:
          - define clean<def[this]> '<def[clean<def[this]>].include[<def[word]>]>'
          - foreach next
        - define text '<def[word].after[<&r><&ss>@<&ss><&chr[260f]>].split[_-_].get[2].replace[\u0026].with[&].unescaped>'
        - define <def[text]> '<def[word].replace[&].with[<&bs><&bs>u0026]>'
        - define clean<def[this]> '<def[clean<def[this]>].include[<def[text]>]>'
      - define clean<def[this]> '<def[clean<def[this]>].separated_by[<&sp>]>'
    - ^define hpad '<def[cleanTitle].length.max[10].as_int>'
    - ^define heading '<def[cleanTitle].pad_right[<def[hpad]>].with[<&sp>]>  <def[cleansubTitle]>'
    - ^define pagesInfo '<&7><&o>Page <&f><def[page]> <&7><&o>of <&f><def[pageTotal]>'
    - ^define pad '<def[pageWidth].sub[<def[heading].strip_color.length>].sub[<def[pagesInfo].strip_color.length>].mul[1.5].round>'
    - ^if !<player.is_player||false>:
      - ^announce to_console "<&5>|<&5.pad_left[<def[pageWidth]>].with[-]>|"
      - ^announce to_console "<&5>|<&sp><&sp><&sp><&6><def[heading]> <&7.pad_right[<def[pad]>].with[ ]><def[pagesInfo]>"
      - ^announce to_console "<&5>|<&f>"
      - ^foreach <def[lines]>:
        - announce to_console "<&5>|<&f><&sp><&sp><def[value].unescaped>"
      - ^announce to_console "<&5>|"
      - ^inject locally msgsFooter
      - ^queue clear

    - ^define finalHeading 'li@'
    - ^foreach '<def[heading].split[ ]>':
      - define c '<def[value].last_color.escaped.after[&ss]>'
      - if '<def[c]>' == '':
        - if <def[lc].exists>:
          - define c '<def[lc]>'
        - else:
          - define c 'white'
      - else:
        - define c '<def[cList].map_get[<def[c]>]>'
      - define lc '<def[c]>'
      - if <def[<def[value]>].exists>:
        - define split '<def[<def[value]>].after[<&ss>@<&ss><&chr[260f]>].split[_-_]>'
        - define type '<def[split].get[1].unescaped>'
        - define text '<def[split].get[2].replace[\u0026].with[&].unescaped> '
        - if '<def[type]>' == 'URL':
          - define url 'http<&co>//<def[split].get[3].replace[\u0026].with[&].unescaped>'
          - define hover '<def[split].get[4].replace[\u0026].with[&].unescaped>'
          - define button '"color":"<def[c]>","text":"<def[text]>","clickEvent":{"action":"open_url","value":"<def[url]>"},"hoverEvent":{"action":"show_text","value":"<def[hover]>"}'
        - else if '<def[type]>' == 'command':
          - define tcommand '/<def[split].get[3].replace[\u0026].with[&].unescaped>'
          - define hover '<def[split].get[4].replace[\u0026].with[&].unescaped>'
          - define button '"color":"<def[c]>","text":"<def[text]>","clickEvent":{"action":"run_command","value":"<def[tcommand]>"},"hoverEvent":{"action":"show_text","value":"<def[hover]>"}'
        - else if '<def[type]>' == 'hint':
          - define hint '/<def[split].get[3].replace[\u0026].with[&].unescaped>'
          - define hover '<def[split].get[4].before_last[<&dq>].replace[\u0026].with[&].unescaped>'
          - define button '"text":"<def[text]>","clickEvent":{"action":"suggest_command","value":"<def[hint]>"},"hoverEvent":{"action":"show_text","value":"<def[hover]>"}'
        - else if '<def[type]>' == 'suggest':
          - define suggest '<def[split].get[3].replace[\u0026].with[&].unescaped>'
          - define hover '<def[split].get[4].before_last[<&dq>].replace[\u0026].with[&].unescaped>'
          - define button '"text":"<def[text]>","clickEvent":{"action":"suggest_command","value":"<def[suggest]>"},"hoverEvent":{"action":"show_text","value":"<def[hover]>"}'
        - else if '<def[type]>' == 'chat':
          - define chat '<def[split].get[3].replace[\u0026].with[&].unescaped>'
          - define hover '<def[split].get[4].replace[\u0026].with[&].unescaped>'
          - define button '"text":"<def[text]>","clickEvent":{"action":"run_command","value":"<def[chat]>"},"hoverEvent":{"action":"show_text","value":"<def[hover]>"}'
        - else if '<def[type]>' == 'hover':
          - define hover '<def[split].get[3].replace[\u0026].with[&].unescaped>'
          - define button '"color":"<def[c]>","text":"<def[text]>","hoverEvent":{"action":"show_text","value":"<def[hover]>"}'

        - define finalHeading '<def[finalHeading].include[{<def[button]>}]>'
      - else:
        - if '<def[value]>' == '':
          - define value '&sp'
        - define finalHeading '<def[finalHeading].include[{"text":"<def[value].strip_color>","color":"<def[c]>"}|{"text":"<&sp>"}]>'
    - ^define finalHeading '<def[finalHeading].separated_by[,].unescaped>'

    - ^inject locally msgsHeader
    - ^inject locally msgsBody
    - ^inject locally msgsFooter

  msgsHeader:
    - ^if <def[page]> == 1:
      - define buttonThis '"text":"1"'
    - else:
      - define iconThis 'i@human_skull[display_name=<proc[msgCentered].context[19|Previous Page]>]'
      - define hoverThis '{<def[iconThis].json>}'
      - define clickThis '/<def[command]> <def[page].sub[1]>'
      - define buttonThis '"text":"<def[page]>","clickEvent":{"action":"run_command","value":"<def[clickThis]>"},"hoverEvent":{"action":"show_item","value":"<def[hoverThis]>"}'
    - ^if <def[page]> == <def[pageTotal]>:
      - define buttonNext '"text":"<def[pageTotal]>"'
    - else:
      - define iconNext 'i@human_skull[display_name=<proc[msgCentered].context[19|Next Page]>]'
      - define hoverNext '{<def[iconNext].json>}'
      - define clickNext '/<def[command]> <def[page].add[1]>'
      - define buttonNext '"text":"<def[pageTotal]>","clickEvent":{"action":"run_command","value":"<def[clickNext]>"},"hoverEvent":{"action":"show_item","value":"<def[hoverNext]>"}'
    - ^define prefix '"text":"<&5>|<&sp><&sp><&sp><&6>"'
    - ^define tpad '"text":"<&7.pad_right[<def[pad]>].with[ ]>"'
    - ^define p '"text":"<&7><&o>Page<&sp>"'
    - ^define o '"text":"<&7><&o><&sp>of<&sp>"'
    - ^narrate "<&5>|<&5.pad_left[<def[pageWidth]>].with[-]>|"
    - ^execute as_server 'tellraw <player.name> {"text":"","extra":[{<def[prefix]>},<def[finalHeading]>,{<def[tpad]>},{<def[p]>},{<def[buttonThis]>},{<def[o]>},{<def[buttonNext]>}]}'
    - ^narrate "<&5>|"

  msgsBody:
    - ^foreach <def[lines]>:
      - narrate "<&5>|<&f><&sp><&sp><def[value].unescaped>"
    - ^repeat <def[pageHeight].sub[<def[lines].size>].as_int>:
      - narrate "<&5>|"
    - ^if <server.list_scripts> contains 's@<def[script]>_Version':
      - define repoVersion '<server.flag[<def[script]>.Version.Repo]||unknown>'
      - define currentVersion '<s@<def[script]>_Version.yaml_key[version]>'
      - define vString '<&7>Version<&co> <&b><def[currentVersion]>'
      - define vPad '<def[pageWidth].sub[<def[vString].strip_color.length>].add[1].mul[1.5].round>'
      - narrate "<&5>|<&f.pad_right[<def[vPad]>]><def[vString]>"
      - if '<def[repoVersion]>' != '<def[currentVersion]>':
        - define uString '<&c><&o>Repo Version<&co> <&b><def[repoVersion]>'
        - define uPad '<def[pageWidth].sub[<def[uString].strip_color.length>].add[1].mul[1.5].round>'
        - define url 'http://one.denizenscript.com/denizen/repo/entry/<s@<def[script]>_Version.yaml_key[id]>'
        - narrate "<&5>|<&f.pad_right[<def[uPad]>]><&c><&o>Repo Version<&co> <proc[msgUrl].context[<&a><def[repoVersion]>|<def[url]>|Click to go to repo!]>"
    - else:
      - narrate "<&5>|"

  msgsFooter:
    - ^define authors '<server.list_scripts.filter[starts_with[s@<def[script]>_Author_]]||li@>'
    - ^if <def[authors].is_empty>:
      - goto 'end'
    - ^define list 'li@'
    - ^define spacer '"text":"  "'
    - ^define prefix '"text":"<&5>|  <&f>Authors<&co>  "'
    - ^foreach <def[authors]>:
      - define text '<def[value].yaml_key[text_name].escaped>'
      - define url '<def[value].yaml_key[url].escaped>'
      - define entry '"text":"<&7><def[text]>","clickEvent":{"action":"open_url","value":"<def[url]>"},"hoverEvent":{"action":"show_item","value":"{<def[value].name.as_item.json>}"}'
      - if <def[loop_index]> == <def[authors].size>:
        - define list '<def[list].include[<&lc><def[entry]><&rc>]>'
      - else:
        - define list '<def[list].include[<&lc><def[entry]><&rc>|<&lc><def[spacer]><&rc>]>'
    - ^if <player.is_player||false>:
      - execute as_server 'tellraw <player.name> {"text":"","extra":[{<def[prefix]>},<def[list].separated_by[,].unescaped>]}'
    - else:
      - announce to_console "<&5>|  <&f>Authors:  <&7><def[authors].parse[.yaml_key[text_name]].split[<&sp><&sp><&7>]>"
    - ^mark 'end'
    - ^define scroll '<&d>S<&5>-<&d>c<&5>-<&d>r<&5>-<&d>o<&5>-<&d>l<&5>-<&d>l<&5>---<&d>U<&5>-<&d>p<&5>'
    - ^define pad '<def[pageWidth].sub[<def[scroll].strip_color.length>].div[2].round_up>'
    - ^narrate "<&5><&5.pad_right[<def[pad]>].with[-]>|-<def[scroll]><&5.pad_left[<def[pad]>].with[-]>|"
#
#  END msgBoxed
#--------------------------------------
#
#  URL Parser
#
# - Allow scripters to easily have clickable text to open urls, run commands, or just show messages on hover
#
#  Example usages at the top of this file.
#
msgParser:
  type: world
  debug: false

  events:
    on player receives message:
    - if !<context.message.contains_text[<&ss>@<&ss><&chr[260f]>]>:
      - queue clear
    - define message '<context.raw_json.after[<&lb>].before_last[<&rb>]>'
    - foreach '<def[message].after[<&lc>].before_last[<&rc>].split[<&rc>,<&lc>].escape_contents>':
      - define element '<def[value].unescaped>'
      - foreach '<def[element].split[<&dq>,<&dq>]>':
        - define node '<def[value]>'
        - define attribute '<def[node].before[<&co>]>'
        - define aValue '<def[node].after[<&co>]>'
        - if '<def[attribute]>' != '<&dq>text<&dq>':
          - foreach next
        - if !<def[aValue].starts_with[<&dq><&ss>@<&ss><&chr[260f]>]>:
          - foreach next
        - define split '<def[aValue].after[<&dq><&ss>@<&ss><&chr[260f]>].split[_-_]>'
        - define type '<def[split].get[1].unescaped>'
        - define text '<def[split].get[2].replace[\\u0026].with[&].replace[\u0026].with[&].unescaped>'
        - choose '<def[split].get[1].unescaped>':
          - case 'URL':
            - define url 'http<&co>//<def[split].get[3].replace[\\u0026].with[&].replace[\u0026].with[&].unescaped>'
            - define hover '<def[split].get[4].before_last[<&dq>].replace[\\u0026].with[&].replace[\u0026].with[&].unescaped>'
            - define button '"text":"<def[text]>","clickEvent":{"action":"open_url","value":"<def[url]>"},"hoverEvent":{"action":"show_text","value":"<def[hover]>"}'
          - case 'command':
            - define command '/<def[split].get[3].replace[\\u0026].with[&].replace[\u0026].with[&].unescaped>'
            - define hover '<def[split].get[4].before_last[<&dq>].replace[\\u0026].with[&].replace[\u0026].with[&].unescaped>'
            - define button '"text":"<def[text]>","clickEvent":{"action":"run_command","value":"<def[command]>"},"hoverEvent":{"action":"show_text","value":"<def[hover]>"}'
          - case 'hint':
            - define command '/<def[split].get[3].replace[\\u0026].with[&].replace[\u0026].with[&].unescaped>'
            - define hover '<def[split].get[4].before_last[<&dq>].replace[\\u0026].with[&].replace[\u0026].with[&].unescaped>'
            - define button '"text":"<def[text]>","clickEvent":{"action":"suggest_command","value":"<def[command]>"},"hoverEvent":{"action":"show_text","value":"<def[hover]>"}'
          - case 'suggest':
            - define command '<def[split].get[3].replace[\\u0026].with[&].replace[\u0026].with[&].unescaped>'
            - define hover '<def[split].get[4].before_last[<&dq>].replace[\\u0026].with[&].replace[\u0026].with[&].unescaped>'
            - define button '"text":"<def[text]>","clickEvent":{"action":"suggest_command","value":"<def[command]>"},"hoverEvent":{"action":"show_text","value":"<def[hover]>"}'
          - case 'chat':
            - define chat '<def[split].get[3].replace[\\u0026].with[&].replace[\u0026].with[&].unescaped>'
            - define hover '<def[split].get[4].before_last[<&dq>].replace[\\u0026].with[&].replace[\u0026].with[&].unescaped>'
            - define button '"text":"<def[text]>","clickEvent":{"action":"run_command","value":"<def[chat]>"},"hoverEvent":{"action":"show_text","value":"<def[hover]>"}'
          - case 'hover':
            - define hover '<def[split].get[3].before_last[<&dq>].replace[\\u0026].with[&].replace[\u0026].with[&].unescaped>'
            - define button '"text":"<def[text]>","hoverEvent":{"action":"show_text","value":"<def[hover]>"}'
        - define message '<def[message].before[<def[node]>]><def[button]><def[message].after[<def[node]>]>'
    - determine 'RAW_JSON:{"extra":[<def[message]>],"text":""}'
#
#  END URL Parser
#--------------------------------------
#
#  Line Wrapping utility
#
# - Turn a long string into a list of smaller strings
#   Treats the <&nl> symbol as intended
#   Preserves the last color used from the previous line
#
#  Usage: <proc[lineWrap].context[string|targetLen]>
#
lineWrap:
  type: procedure
  definitions: string|targetLen
  debug: false

  script:
    - define cleanString 'li@'
    - foreach '<def[string].split[ ]>':
      - if '<def[value]>' == '':
        - define cleanString '<def[cleanString].include[&sp]>'
        - foreach next
      - define word '<def[value]>'
      - if !<def[word].starts_with[<&r><&ss>@<&ss><&chr[260f]>]>:
        - define cleanString '<def[cleanString].include[<def[word]>]>'
        - foreach next
      - define text '<def[word].after[<&r><&ss>@<&ss><&chr[260f]>].split[_-_].get[2].replace[\u0026].with[&].unescaped>'
      - define <def[loop_index]> '<def[word].replace[&].with[<&bs><&bs>u0026]>'
      - define cleanString '<def[cleanString].include[<def[text]>]>'

    - if <def[cleanString].is_empty>:
      - determine 'li@ '
    - define cleanString '<def[cleanString].separated_by[ ]>'
    - define stringLen '<def[cleanString].unescaped.length>'
    - if <def[stringLen]> <= <def[targetLen]>:
      - define finalString 'li@'
      - foreach '<def[cleanString].split[ ]>':
        - if <def[<def[loop_index]>].exists>:
          - define finalString '<def[finalString].include[<def[<def[loop_index]>]>]>'
        - else:
          - if '<def[value]>' == '':
            - define value '&sp'
          - define finalString '<def[finalString].include[<def[value]>]>'
      - determine '<def[finalString].separated_by[<&sp>].as_list>'
    - define c '<&f>'
    - define lines 'li@'
    - while '<def[stringLen].is[MORE].than[0]>':
      - define low '<def[increment].add[1].as_int||1>'
      - define hi '<def[increment].add[<def[targetLen].add[1]>].as_int||<def[targetLen]>>'
      - define pass '<def[cleanString].unescaped.substring[<def[low]>,<def[hi]>]>'
      - if <def[pass].length> == <def[stringLen]>:
        - define lines '<def[lines].include[<def[c]><def[pass].escaped>]>'
        - while stop
      - else:
        - define brake '<tern[<def[pass].contains[<&nl>]>]:<def[pass].index_of[<&nl>]>||<def[pass].last_index_of[<&sp>]>>'
        - define increment '<def[increment].add[<def[brake]>]||<def[brake]>>'
        - define passtrim '<def[c]><def[pass].unescaped.substring[1,<tern[<def[brake].is[MORE].than[0]>]:<def[brake]>||<def[pass].length>>]>'
        - define lines '<def[lines].include[<def[passtrim].escaped>]||<def[lines]>>'
        - define c '<def[passtrim].last_color||<&f>>'
        - define stringLen '<def[stringLen].sub[<def[brake]>]>'
      - if <def[loop_index].is[MORE].than[10]>:
        - while stop
    - define i '0'
    - define finalLines 'li@'
    - foreach '<def[lines]>':
      - define finalString 'li@'
      - foreach '<def[value].split[ ]>':
        - define i '<def[i].add[1].as_int>'
        - if <def[<def[i]>].exists>:
          - define finalString '<def[finalString].include[<def[<def[i]>]>]>'
        - else:
          - if '<def[value]>' == '':
            - define value '<&sp>'
          - define finalString '<def[finalString].include[<def[value]>]>'
      - define finalLines '<def[finalLines].include[<def[finalString].separated_by[<&sp>]>]>'
    - determine '<def[finalLines].as_list>'
#
#  END lineWrap
#--------------------------------------
#
#  Pagination utility
#
#  - Return a list of entries for display on a specific page
#    Pagination simply takes a list of entries, and the desired page length and
#    returns only the entries for the desired page number.
#
#  Usage: <proc[pagination].context[page|pageLen|list|...]>
#
pagination:
  type: procedure
  definitions: page|pageSize
  debug: false

  script:
    - define entries '<def[raw_context].split[|].remove[1|2]>'
    - foreach 'li@page|pageSize':
      - define <def[value]> '<def[raw_context].split[|].get[<def[loop_index]>]>'
    - if <def[page].is[MATCHES].to[number].not>:
      - define page '1'
    - else:
      - define page '<def[page].abs.round>'
    - define pages '<def[entries].size.div[<def[pageSize]||5>].round_up||1>'
    - if <def[page].is[MORE].than[<def[pages]>]>:
      - define page '<def[pages]>'
    - define highNumber '<def[page].mul[<def[pageSize]||5>].as_int>'
    - define lowNumber '<def[highNumber].sub[<def[pageSize].sub[1]||4>].as_int>'
    - determine 'li@<def[page]>|<def[pages]>|<def[entries].get[<def[lowNumber]>].to[<def[highNumber]>].separated_by[|]||li@>'
#
#  END pagination
#--------------------------------------
#
#  Paragraph utility
#
#  Turns a list of entries into a list of lines limited in length.
#  - Useful if you want to limit total page size not just entries per page.
#
#  Usage: <proc[paragraph].context[lineLen|list|...]>
#
paragraph:
  type: procedure
  definitions: lineLen
  debug: false

  script:
    - define paragraphs '<def[raw_context].split[|].remove[1]>'
    - define lineLen '<def[raw_context].split[|].get[1]>'
    - define lineLen '<tern[<def[lineLen].is[matches].to[number].and[<def[lineLen].is[MORE].than[0]>]>]:<def[lineLen]>||44>'
    - define result 'li@'
    - foreach '<def[paragraphs]>':
      - define lines '<proc[lineWrap].context[<def[value]>|<def[lineLen]||44>]>'
      - foreach '<def[lines]>':
        - define result '<def[result].include[<def[value]>]>'
    - determine '<def[result]>'
#
# Put this inside the second foreach just before it closes to automatically
# insert a newline at the end of each paragraph.
#      - define result '<def[result].include[<&sp>]>'
#
#  END paragraph
#--------------------------------------
#
#  Center Justified Utility
#
#  Returns your text center justified based on target line length
#
#  Usage: <proc[msgCentered].context[lineLen|string]>
#
msgCentered:
  type: procedure
  definitions: lineLen|string
  debug: false

  script:
    - define pad '<el@val[<def[lineLen]>].sub[<def[string].length>].div[2].as_int>'
    - determine '<&6.pad_right[<def[pad]>].with[<&sp>]><def[string]><&6.pad_right[<def[pad]>].with[<&sp>]>'
#
#  END msgCentered
#--------------------------------------
#
#  Trimmed Message Utility
#
#  Returns your text trimmed to fit a specified length.
#  Extra text is shown as an elipsis...
#
#  Usage: <proc[msgTrim].context[lineLen|string]>
#
msgTrim:
  type: procedure
  definitions: lineLen|string
  debug: false

  script:
    - if <def[string].length> > <def[linelen]>:
      - determine '<def[string].unescaped.substring[1,<def[lineLen].sub[3].as_int||40>].escaped>...'
    - determine '<def[string]>'
#
#  END msgTrim
#--------------------------------------
#
#  URL Message Formatter
#
#  Returns your text formatted for automatic conversion to JSON.
#
#  Usage: <proc[msgUrl].context[<def[display]>|<def[url]>|<def[hover]>]>
#
msgUrl:
  type: procedure
  definitions: display|url|hover
  debug: false

  script:
    - determine '<&r><&ss>@<&ss><&chr[260f]>URL_-_<def[display].escaped.replace[ ].with[&sp]>_-_<def[url].escaped.replace[ ].with[&sp]>_-_<def[hover].escaped.replace[ ].with[&sp]><&r>'
#
#  END msgUrl
#--------------------------------------
#
#  Command Message Formatter
#
#  Returns your text formatted for automatic conversion to JSON.
#
#  Usage: <proc[msgCommand].context[<def[display]>|<def[command]>|<def[hover]>]>
#
msgCommand:
  type: procedure
  definitions: display|command|hover
  debug: false

  script:
    - determine '<&r><&ss>@<&ss><&chr[260f]>command_-_<def[display].escaped.replace[ ].with[&sp]>_-_<def[command].escaped.replace[ ].with[&sp]>_-_<def[hover].escaped.replace[ ].with[&sp]><&r>'
#
#  END msgCommand
#--------------------------------------
#
#  Hover Message Formatter
#
#  Returns your text formatted for automatic conversion to JSON.
#
#  Usage: <proc[msgHover].context[<def[display]>|<def[hover]>]>
#
msgHover:
  type: procedure
  definitions: display|hover
  debug: false

  script:
    - determine '<&r><&ss>@<&ss><&chr[260f]>hover_-_<def[display].escaped.replace[ ].with[&sp]>_-_<def[hover].escaped.replace[ ].with[&sp]><&r>'
#
#  END msgHover
#--------------------------------------
#
#  Hint Message Formatter
#
#  Returns your text formatted for automatic conversion to JSON.
#
#  Usage: <proc[msgHint].context[<def[display]>|<def[hint]>|<def[hover]>]>
#
msgHint:
  type: procedure
  definitions: display|hint|hover
  debug: false

  script:
    - determine '<&r><&ss>@<&ss><&chr[260f]>hint_-_<def[display].escaped.replace[ ].with[&sp]>_-_<def[hint].escaped.replace[ ].with[&sp]>_-_<def[hover].escaped.replace[ ].with[&sp]><&r>'
#
#  END msgHint
#--------------------------------------
#
#  Suggest Message Formatter
#
#  Returns your text formatted for automatic conversion to JSON.
#
#  Usage: <proc[msgSuggest].context[<def[display]>|<def[suggest]>|<def[hover]>]>
#
msgSuggest:
  type: procedure
  definitions: display|suggest|hover
  debug: false

  script:
    - determine '<&r><&ss>@<&ss><&chr[260f]>suggest_-_<def[display].escaped.replace[ ].with[&sp]>_-_<def[suggest].escaped.replace[ ].with[&sp]>_-_<def[hover].escaped.replace[ ].with[&sp]><&r>'
#
#  END msgSuggest
#--------------------------------------
#
#  Chat Message Formatter
#
#  Returns your text formatted for automatic conversion to JSON.
#  This will make it so that a player chats the message they click.
#  Good for situations where an NPC is expecting chat input.
#
#  Usage: <proc[msgChat].context[<def[display]>|<def[chat]>|<def[hover]>]>
#
msgChat:
  type: procedure
  definitions: display|chat|hover
  debug: false

  script:
    - determine '<&r><&ss>@<&ss><&chr[260f]>chat_-_<def[display].escaped.replace[ ].with[&sp]>_-_<def[chat].escaped.replace[ ].with[&sp]>_-_<def[hover].escaped.replace[ ].with[&sp]><&r>'
#
#  END msgChat
#
#
#
################################################################################
