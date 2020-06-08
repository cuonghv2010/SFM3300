                                      1 .module INIT
                                      2 .macro jump addr
                                      3     jp 0x8280 + addr
                                      4     .ds 1
                                      5 .endm
                                      6 
                                      7 .area IVT
      008000 82 00 80 80              8 int init ; reset
      000004                          9 jump 0x4 ; trap
      008004 CC 82 84         [ 2]    1     jp 0x8280 + 0x4
      008007                          2     .ds 1
      000008                         10 jump 0x8 ; int0
      008008 CC 82 88         [ 2]    1     jp 0x8280 + 0x8
      00800B                          2     .ds 1
      00000C                         11 jump 0xc ; int1
      00800C CC 82 8C         [ 2]    1     jp 0x8280 + 0xc
      00800F                          2     .ds 1
      000010                         12 jump 0x10 ; int2
      008010 CC 82 90         [ 2]    1     jp 0x8280 + 0x10
      008013                          2     .ds 1
      000014                         13 jump 0x14 ; int3
      008014 CC 82 94         [ 2]    1     jp 0x8280 + 0x14
      008017                          2     .ds 1
      000018                         14 jump 0x18 ; int4
      008018 CC 82 98         [ 2]    1     jp 0x8280 + 0x18
      00801B                          2     .ds 1
      00001C                         15 jump 0x1c ; int5
      00801C CC 82 9C         [ 2]    1     jp 0x8280 + 0x1c
      00801F                          2     .ds 1
      000020                         16 jump 0x20 ; int6
      008020 CC 82 A0         [ 2]    1     jp 0x8280 + 0x20
      008023                          2     .ds 1
      000024                         17 jump 0x24 ; int7
      008024 CC 82 A4         [ 2]    1     jp 0x8280 + 0x24
      008027                          2     .ds 1
      000028                         18 jump 0x28 ; int8
      008028 CC 82 A8         [ 2]    1     jp 0x8280 + 0x28
      00802B                          2     .ds 1
      00002C                         19 jump 0x2c ; int9
      00802C CC 82 AC         [ 2]    1     jp 0x8280 + 0x2c
      00802F                          2     .ds 1
      000030                         20 jump 0x30 ; int10
      008030 CC 82 B0         [ 2]    1     jp 0x8280 + 0x30
      008033                          2     .ds 1
      000034                         21 jump 0x34 ; int11
      008034 CC 82 B4         [ 2]    1     jp 0x8280 + 0x34
      008037                          2     .ds 1
      000038                         22 jump 0x38 ; int12
      008038 CC 82 B8         [ 2]    1     jp 0x8280 + 0x38
      00803B                          2     .ds 1
      00003C                         23 jump 0x3c ; int13
      00803C CC 82 BC         [ 2]    1     jp 0x8280 + 0x3c
      00803F                          2     .ds 1
      000040                         24 jump 0x40 ; int14
      008040 CC 82 C0         [ 2]    1     jp 0x8280 + 0x40
      008043                          2     .ds 1
      000044                         25 jump 0x44 ; int15
      008044 CC 82 C4         [ 2]    1     jp 0x8280 + 0x44
      008047                          2     .ds 1
      000048                         26 jump 0x48 ; int16
      008048 CC 82 C8         [ 2]    1     jp 0x8280 + 0x48
      00804B                          2     .ds 1
      00004C                         27 jump 0x4c ; int17
      00804C CC 82 CC         [ 2]    1     jp 0x8280 + 0x4c
      00804F                          2     .ds 1
      000050                         28 jump 0x50 ; int18
      008050 CC 82 D0         [ 2]    1     jp 0x8280 + 0x50
      008053                          2     .ds 1
      000054                         29 jump 0x54 ; int19
      008054 CC 82 D4         [ 2]    1     jp 0x8280 + 0x54
      008057                          2     .ds 1
      000058                         30 jump 0x58 ; int20
      008058 CC 82 D8         [ 2]    1     jp 0x8280 + 0x58
      00805B                          2     .ds 1
      00005C                         31 jump 0x5c ; int21
      00805C CC 82 DC         [ 2]    1     jp 0x8280 + 0x5c
      00805F                          2     .ds 1
      000060                         32 jump 0x60 ; int22
      008060 CC 82 E0         [ 2]    1     jp 0x8280 + 0x60
      008063                          2     .ds 1
      000064                         33 jump 0x64 ; int23
      008064 CC 82 E4         [ 2]    1     jp 0x8280 + 0x64
      008067                          2     .ds 1
      000068                         34 jump 0x68 ; int24
      008068 CC 82 E8         [ 2]    1     jp 0x8280 + 0x68
      00806B                          2     .ds 1
      00006C                         35 jump 0x6c ; int25
      00806C CC 82 EC         [ 2]    1     jp 0x8280 + 0x6c
      00806F                          2     .ds 1
      000070                         36 jump 0x70 ; int26
      008070 CC 82 F0         [ 2]    1     jp 0x8280 + 0x70
      008073                          2     .ds 1
      000074                         37 jump 0x74 ; int27
      008074 CC 82 F4         [ 2]    1     jp 0x8280 + 0x74
      008077                          2     .ds 1
      000078                         38 jump 0x78 ; int28
      008078 CC 82 F8         [ 2]    1     jp 0x8280 + 0x78
      00807B                          2     .ds 1
      00007C                         39 jump 0x7c ; int29
      00807C CC 82 FC         [ 2]    1     jp 0x8280 + 0x7c
      00807F                          2     .ds 1
                                     40 
                                     41 .area SSEG
                                     42 .area GSINIT
      008080                         43 init:
      008080 AE 01 42         [ 2]   44     ldw x, #l_DATA
      008083 27 07            [ 1]   45     jreq    00002$
      008085                         46 00001$:
      008085 72 4F 00 00      [ 1]   47     clr (s_DATA - 1, x)
      008089 5A               [ 2]   48     decw x
      00808A 26 F9            [ 1]   49     jrne    00001$
      00808C                         50 00002$:
      00808C AE 00 02         [ 2]   51     ldw x, #l_INITIALIZER
      00808F 27 09            [ 1]   52     jreq    00004$
      008091                         53 00003$:
      008091 D6 80 9C         [ 1]   54     ld  a, (s_INITIALIZER - 1, x)
      008094 D7 01 42         [ 1]   55     ld  (s_INITIALIZED - 1, x), a
      008097 5A               [ 2]   56     decw    x
      008098 26 F7            [ 1]   57     jrne    00003$
      00809A                         58 00004$:
      00809A CC 81 2D         [ 2]   59     jp  _bootloader_main
