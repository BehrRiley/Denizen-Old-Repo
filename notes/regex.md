Full Line:
    Non Quote: 
        Yaml Keys: ^[^#\s].*[:].*
        In-Line Yaml Keys: ^[\s]+[^-].*$
        Command Line: ^[\s]*[-].*

yaml key captures:
    colons: 
        begin: :(?=\s|$|[\[\]{},])
        end: (?=[},\\]])
inline yaml key captures:
command line captures:
    dash: (-)(?!\S)
    command: 
    args: ((\s+[^\s'"]+:[^\s'"]+)|(\s+'[^\s'"]+:[^'"]+')|(\s+"[^\s'"]+:[^'"]+"))


[tag stuff]:
    captures:
        begin: 
        end: (?=[},\]])
    command nodes: (\w|"(.*?)"|'(.*?)')*:(<[^>](.*?)>)

  (?<=(\s-\s)).*
: 
(
    (                                         # arg:args
        (?<=(\s-\s)).*(\s+[^\s'"]+:[^\s'"]+)  # arg: no spaces
        |(?<=(\s-\s)).*(\s+'[^\s'"]+:[^'"]+') # arg: apos. wrapped
        |(?<=(\s-\s)).*(\s+"[^\s'"]+:[^'"]+") # arg: quo. wrapped
    )   
    |\S+                                      # single arg
)
