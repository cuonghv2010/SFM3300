;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.8.0 #10562 (Linux)
;--------------------------------------------------------
	.module main
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _bootloader_main
	.globl _ram_flash_write_block
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area DATA
_CRC:
	.ds 1
_ivt:
	.ds 128
_f_ram:
	.ds 128
_rx_buffer:
	.ds 64
_RAM_SEG_LEN:
	.ds 1
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area INITIALIZED
_flash_write_block:
	.ds 2
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area DABS (ABS)

; default segment ordering for linker
	.area HOME
	.area GSINIT
	.area GSFINAL
	.area CONST
	.area INITIALIZER
	.area CODE

;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area HOME
	.area GSINIT
	.area GSFINAL
	.area GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area HOME
	.area HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area CODE
;	main.c: 56: static void uart_write(uint8_t data) {
;	-----------------------------------------
;	 function uart_write
;	-----------------------------------------
_uart_write:
;	main.c: 58: RS485dir_ODR = 1 << RS485dir_PIN;	//RS485 TX mode, high
	mov	0x500f+0, #0x10
;	main.c: 59: for (ix=0;ix<10;ix++); //delay for before transmit
	ld	a, #0x0a
00108$:
	dec	a
	tnz	a
	jrne	00108$
;	main.c: 60: UART_DR = data;
	ldw	x, #0x5231
	ld	a, (0x03, sp)
	ld	(x), a
;	main.c: 61: while (!(UART_SR & (1 << UART_SR_TC)));
00102$:
	ld	a, 0x5230
	bcp	a, #0x40
	jreq	00102$
;	main.c: 62: for (ix=0;ix<10;ix++); //delay for before transmit
	ld	a, #0x0a
00111$:
	dec	a
	tnz	a
	jrne	00111$
;	main.c: 63: RS485dir_ODR = 0;					//RS485 RX mode, low
	mov	0x500f+0, #0x00
;	main.c: 64: }
	ret
;	main.c: 69: static uint8_t uart_read() {
;	-----------------------------------------
;	 function uart_read
;	-----------------------------------------
_uart_read:
;	main.c: 36: IWDG_KR = IWDG_KEY_REFRESH;
	mov	0x50e0+0, #0xaa
;	main.c: 71: while (!(UART_SR & (1 << UART_SR_RXNE)));
00101$:
	ld	a, 0x5230
	bcp	a, #0x20
	jreq	00101$
;	main.c: 72: return UART_DR;
	ld	a, 0x5231
;	main.c: 73: }
	ret
;	main.c: 93: static void serial_send_ack() {
;	-----------------------------------------
;	 function serial_send_ack
;	-----------------------------------------
_serial_send_ack:
;	main.c: 94: uart_write(0xAA);
	push	#0xaa
	call	_uart_write
	pop	a
;	main.c: 95: uart_write(0xBB);
	push	#0xbb
	call	_uart_write
	pop	a
;	main.c: 96: }
	ret
;	main.c: 111: static void serial_read_block(uint8_t *dest) {
;	-----------------------------------------
;	 function serial_read_block
;	-----------------------------------------
_serial_read_block:
	sub	sp, #5
;	main.c: 112: serial_send_ack();
	call	_serial_send_ack
;	main.c: 113: for (uint8_t i = 0; i < BLOCK_SIZE; i++) {
	clr	(0x05, sp)
00108$:
	ld	a, (0x05, sp)
	cp	a, #0x40
	jrnc	00110$
;	main.c: 114: uint8_t rx = uart_read();
	call	_uart_read
	ld	(0x04, sp), a
;	main.c: 115: dest[i] = rx;
	clrw	x
	ld	a, (0x05, sp)
	ld	xl, a
	addw	x, (0x08, sp)
	ld	a, (0x04, sp)
	ld	(x), a
;	main.c: 116: CRC = crc8_update(rx, CRC);
	ld	a, _CRC+0
;	main.c: 84: crc ^= data;
	xor	a, (0x04, sp)
	ld	xh, a
;	main.c: 85: for (uint8_t i = 0; i < 8; i++)
	clr	(0x03, sp)
00105$:
	ld	a, (0x03, sp)
	cp	a, #0x08
	jrnc	00102$
;	main.c: 86: crc = (crc & 0x80) ? (crc << 1) ^ 0x07 : crc << 1;
	ld	a, xh
	sll	a
	ld	(0x02, sp), a
	ld	a, (0x02, sp)
	rlc	a
	clr	a
	sbc	a, #0x00
	ld	xl, a
	tnzw	x
	jrpl	00112$
	ld	a, (0x02, sp)
	xor	a, #0x07
	jra	00113$
00112$:
	ld	a, (0x02, sp)
00113$:
	ld	xh, a
;	main.c: 85: for (uint8_t i = 0; i < 8; i++)
	inc	(0x03, sp)
	jra	00105$
00102$:
;	main.c: 116: CRC = crc8_update(rx, CRC);
	ld	a, xh
	ld	_CRC+0, a
;	main.c: 113: for (uint8_t i = 0; i < BLOCK_SIZE; i++) {
	inc	(0x05, sp)
	jra	00108$
00110$:
;	main.c: 118: }
	addw	sp, #5
	ret
;	main.c: 200: void bootloader_main() {
;	-----------------------------------------
;	 function bootloader_main
;	-----------------------------------------
_bootloader_main:
	sub	sp, #8
;	main.c: 202: BOOT_PIN_CR1 = 1 << BOOT_PIN;
	mov	0x5012+0, #0x08
;	main.c: 203: if ((BOOT_PIN_IDR & (1 << BOOT_PIN))) {
	ld	a, 0x5010
	bcp	a, #0x08
	jrne	00224$
	jp	00102$
00224$:
;	main.c: 205: CLK_CKDIVR = 0;
	mov	0x50c6+0, #0x00
;	main.c: 18: __asm__("mov _RAM_SEG_LEN, #l_RAM_SEG");
	mov	_RAM_SEG_LEN, #l_RAM_SEG
;	main.c: 196: for (uint8_t i = 0; i < RAM_SEG_LEN; i++)
	clr	a
00132$:
	cp	a, _RAM_SEG_LEN+0
	jrnc	00106$
;	main.c: 197: f_ram[i] = ((uint8_t *) ram_flash_write_block)[i];
	clrw	y
	ld	yl, a
	addw	y, #_f_ram
	ldw	x, #_ram_flash_write_block
	ldw	(0x01, sp), x
	clrw	x
	ld	xl, a
	addw	x, (0x01, sp)
	push	a
	ld	a, (x)
	ld	(y), a
	pop	a
;	main.c: 196: for (uint8_t i = 0; i < RAM_SEG_LEN; i++)
	inc	a
	jra	00132$
;	main.c: 206: ram_cpy();
00106$:
;	main.c: 26: IWDG_KR = IWDG_KEY_ENABLE;
	mov	0x50e0+0, #0xcc
;	main.c: 27: IWDG_KR = IWDG_KEY_ACCESS;
	mov	0x50e0+0, #0x55
;	main.c: 28: IWDG_PR = 2;
	mov	0x50e1+0, #0x02
;	main.c: 29: IWDG_KR = IWDG_KEY_REFRESH;
	mov	0x50e0+0, #0xaa
;	main.c: 47: UART_BRR2 = ((UART_DIV >> 8) & 0xF0) + (UART_DIV & 0x0F);
	mov	0x5233+0, #0x0b
;	main.c: 48: UART_BRR1 = UART_DIV >> 4;
	mov	0x5232+0, #0x08
;	main.c: 50: UART_CR2 = (1 << UART_CR2_TEN) | (1 << UART_CR2_REN);
	mov	0x5235+0, #0x0c
;	main.c: 209: RS485dir_CR1 = 1 << RS485dir_PIN;	//push-pull out mode
	mov	0x5012+0, #0x10
;	main.c: 210: RS485dir_DDR = 1 << RS485dir_PIN;	//direction set to out
	mov	0x5011+0, #0x10
;	main.c: 211: RS485dir_ODR = 0;			//RS485 RX mode, low	
	mov	0x500f+0, #0x00
;	main.c: 125: uint16_t addr = BOOT_ADDR;
	ldw	x, #0x8280
	ldw	(0x05, sp), x
;	main.c: 156: FLASH_PUKR = FLASH_PUKR_KEY1;
00134$:
;	main.c: 129: uint8_t rx = uart_read();
	call	_uart_read
;	main.c: 130: if (rx != 0xDE) continue;
	cp	a, #0xde
	jrne	00134$
;	main.c: 131: rx = uart_read();
	call	_uart_read
;	main.c: 132: if (rx != 0xAD) continue;
	cp	a, #0xad
	jrne	00134$
;	main.c: 133: rx = uart_read();
	call	_uart_read
;	main.c: 134: if (rx != 0xBE) continue;
	cp	a, #0xbe
	jrne	00134$
;	main.c: 135: rx = uart_read();
	call	_uart_read
;	main.c: 136: if (rx != 0xEF) continue;
	cp	a, #0xef
	jrne	00134$
;	main.c: 137: chunks = uart_read();
	call	_uart_read
	ld	(0x08, sp), a
;	main.c: 138: crc_rx = uart_read();
	call	_uart_read
	ld	(0x07, sp), a
;	main.c: 139: rx = uart_read();
	call	_uart_read
	ld	(0x03, sp), a
;	main.c: 140: if (crc_rx != rx)
	ld	a, (0x07, sp)
	cp	a, (0x03, sp)
	jrne	00134$
;	main.c: 156: FLASH_PUKR = FLASH_PUKR_KEY1;
	mov	0x5062+0, #0x56
;	main.c: 157: FLASH_PUKR = FLASH_PUKR_KEY2;
	mov	0x5062+0, #0xae
;	main.c: 158: while (!(FLASH_IAPSR & (1 << FLASH_IAPSR_PUL)));
00121$:
	ld	a, 0x505f
	bcp	a, #0x02
	jreq	00121$
;	main.c: 161: for (uint8_t i = 0; i < chunks; i++) {
	clr	(0x04, sp)
00136$:
	ld	a, (0x04, sp)
	cp	a, (0x08, sp)
	jrnc	00124$
;	main.c: 162: serial_read_block(rx_buffer);
	push	#<_rx_buffer
	push	#(_rx_buffer >> 8)
	call	_serial_read_block
	popw	x
;	main.c: 163: flash_write_block(addr, rx_buffer);
	push	#<_rx_buffer
	push	#(_rx_buffer >> 8)
	ldw	x, (0x07, sp)
	pushw	x
	ldw	x, _flash_write_block+0
	call	(x)
	addw	sp, #4
;	main.c: 164: addr += BLOCK_SIZE;
	ldw	x, (0x05, sp)
	addw	x, #0x0040
	ldw	(0x05, sp), x
;	main.c: 161: for (uint8_t i = 0; i < chunks; i++) {
	inc	(0x04, sp)
	jra	00136$
00124$:
;	main.c: 168: if (CRC != crc_rx) {
	ld	a, (0x07, sp)
	cp	a, _CRC+0
	jreq	00128$
;	main.c: 102: uart_write(0xDE);
	push	#0xde
	call	_uart_write
	pop	a
;	main.c: 103: uart_write(0xAD);
	push	#0xad
	call	_uart_write
	pop	a
;	main.c: 169: serial_send_nack();
00139$:
	jra	00139$
00128$:
;	main.c: 183: FLASH_IAPSR &= ~(1 << FLASH_IAPSR_PUL);
	bres	20575, #1
;	main.c: 185: serial_send_ack();
	call	_serial_send_ack
00141$:
	jra	00141$
;	main.c: 212: bootloader_exec();
00102$:
;	main.c: 215: BOOT_PIN_CR1 = 0x00;
	mov	0x5012+0, #0x00
;	main.c: 216: BOOT();
	jp	0x8280
;	main.c: 218: }
	addw	sp, #8
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
__xinit__flash_write_block:
	.dw _f_ram
	.area CABS (ABS)
