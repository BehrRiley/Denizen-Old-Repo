# : ███████████████████████████████████████████████████████████ 
# : ██   Quality Universal Object Procedure
# : ██
# | ██ [ Calculation Assignment ] ██
# % ██ [                                                   ] ██
# % ██ [ This document is a historical reference and is UC ] ██
# % ██ [                                                   ] ██
iQuop_Calc:
    type: procedure
    definitions: Durability|Quantity|Stacks|ExistQuantity|Display
    script:
      # - is the item a custom item?
      - if <[Durability]> !matches number:
        - define Durability <s@ItemReference.yaml_key[<[Durability].replace[/].with[.]>]||1>
      # - Does a custom quantity exist?
      - if <[ExistQuantity]||> != "" && <[ExistQuantity]> matches number:
        - define Quantity <[ExistQuantity].add[Quantity]>
      # -
      - if <[Quantity]> !matches number:
        - define Quantity 1
      # - Does the item dynamically stack?
      - else if <[Stacks]||false>:
        - define StackNBT ";nbt=SNBT/<[quantity]>"
        # - Is the quantity over 99.9M?
        - if <[Quantity]> > 99999999:
          - define CC <&a>
          - define CoinDV <[Quantity].div[1000000].round_down>M
        # - Is the quantity over 99.9K?
        - else if <[Quantity]> > 99999:
          - define CC <&f>
          - define CoinDV <[Quantity].div[1000].round_down>K
        # - Quantity is less than 100k?
        - else:
          - define CC <&f>
        - define Lore ";lore=<&8>Quantity<&co><[cc]> <[CoinDV]||<[Quantity]>><[StackNBT]>"
        # - Does the item already have a custom quantity?
        - if <[existquantity]||false>:
          - define quantity 1
      - else:
        - define CoinV ""
      # -
      - if <[Display]||> == "":
        - define Display_name <s@ItemReference.yaml_key[<[Durability].after[/]>]||Error>
      - determine "Durability=<[Durability]>;Display_name=<[Display_name]||<[Display]>>;Quantity=<[Quantity]><[Lore]>" 
