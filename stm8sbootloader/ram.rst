                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ANSI-C Compiler
                                      3 ; Version 3.8.0 #10562 (Linux)
                                      4 ;--------------------------------------------------------
                                      5 	.module ram
                                      6 	.optsdcc -mstm8
                                      7 	
                                      8 ;--------------------------------------------------------
                                      9 ; Public variables in this module
                                     10 ;--------------------------------------------------------
                                     11 	.globl _ram_flash_write_block
                                     12 ;--------------------------------------------------------
                                     13 ; ram data
                                     14 ;--------------------------------------------------------
                                     15 	.area DATA
                                     16 ;--------------------------------------------------------
                                     17 ; ram data
                                     18 ;--------------------------------------------------------
                                     19 	.area INITIALIZED
                                     20 ;--------------------------------------------------------
                                     21 ; absolute external ram data
                                     22 ;--------------------------------------------------------
                                     23 	.area DABS (ABS)
                                     24 
                                     25 ; default segment ordering for linker
                                     26 	.area HOME
                                     27 	.area GSINIT
                                     28 	.area GSFINAL
                                     29 	.area CONST
                                     30 	.area INITIALIZER
                                     31 	.area CODE
                                     32 
                                     33 ;--------------------------------------------------------
                                     34 ; global & static initialisations
                                     35 ;--------------------------------------------------------
                                     36 	.area HOME
                                     37 	.area GSINIT
                                     38 	.area GSFINAL
                                     39 	.area GSINIT
                                     40 ;--------------------------------------------------------
                                     41 ; Home
                                     42 ;--------------------------------------------------------
                                     43 	.area HOME
                                     44 	.area HOME
                                     45 ;--------------------------------------------------------
                                     46 ; code
                                     47 ;--------------------------------------------------------
                                     48 	.area RAM_SEG
                                     49 ;	ram.c: 6: void ram_flash_write_block(uint16_t addr, const uint8_t *buf) {
                                     50 ;	-----------------------------------------
                                     51 ;	 function ram_flash_write_block
                                     52 ;	-----------------------------------------
      008222                         53 _ram_flash_write_block:
                                     54 ;	ram.c: 8: FLASH_CR2 = 1 << FLASH_CR2_PRG;
      008222 35 01 50 5B      [ 1]   55 	mov	0x505b+0, #0x01
                                     56 ;	ram.c: 10: FLASH_NCR2 = (uint8_t) ~(1 << FLASH_NCR2_NPRG);
      008226 35 FE 50 5C      [ 1]   57 	mov	0x505c+0, #0xfe
                                     58 ;	ram.c: 14: for (uint8_t i = 0; i < BLOCK_SIZE; i++)
      00822A 4F               [ 1]   59 	clr	a
      00822B                         60 00106$:
      00822B A1 40            [ 1]   61 	cp	a, #0x40
      00822D 24 14            [ 1]   62 	jrnc	00102$
                                     63 ;	ram.c: 15: _MEM_(addr + i) = buf[i];
      00822F 5F               [ 1]   64 	clrw	x
      008230 97               [ 1]   65 	ld	xl, a
      008231 72 FB 03         [ 2]   66 	addw	x, (0x03, sp)
      008234 51               [ 1]   67 	exgw	x, y
      008235 5F               [ 1]   68 	clrw	x
      008236 97               [ 1]   69 	ld	xl, a
      008237 72 FB 05         [ 2]   70 	addw	x, (0x05, sp)
      00823A 88               [ 1]   71 	push	a
      00823B F6               [ 1]   72 	ld	a, (x)
      00823C 97               [ 1]   73 	ld	xl, a
      00823D 90 F7            [ 1]   74 	ld	(y), a
      00823F 84               [ 1]   75 	pop	a
                                     76 ;	ram.c: 14: for (uint8_t i = 0; i < BLOCK_SIZE; i++)
      008240 4C               [ 1]   77 	inc	a
      008241 20 E8            [ 2]   78 	jra	00106$
                                     79 ;	ram.c: 18: while (!(FLASH_IAPSR & (1 << FLASH_IAPSR_EOP)));
      008243                         80 00102$:
      008243 C6 50 5F         [ 1]   81 	ld	a, 0x505f
      008246 A5 04            [ 1]   82 	bcp	a, #0x04
      008248 27 F9            [ 1]   83 	jreq	00102$
                                     84 ;	ram.c: 19: }
      00824A 81               [ 4]   85 	ret
                                     86 	.area CODE
                                     87 	.area CONST
                                     88 	.area INITIALIZER
                                     89 	.area CABS (ABS)
