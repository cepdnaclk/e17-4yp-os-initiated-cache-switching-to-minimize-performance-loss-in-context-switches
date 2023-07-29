# Instruction testing

## Instructions

1. LUI

- Instruction format

    ![Alt text](assets/LUI_IF.png)

- Instruction State Transer Model

        rd &larr; imm << 12
- Type: 
        
        U - Type
- Format

        LUI RD, IMM
- Example

    ```
    LUI x0, 500
    ```
    ```
    00000000000111110100 00000 0110111
    ```
    ```
    001f4037
    ```
- Datapath

    ![Alt text](assets/Datapaths/datapath_LUI.png)