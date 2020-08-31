;The implementation of an if-statement in C-language is demonstrated
; if(a>b) x=c+1;
; else if(a < b) y=d-1;
; else 
; {
;   x=0;
;   y=255;
; }
;All the variables are defined as user-defined registers
;******************Header Files******************************
list	    p=18f4550        ; list directive to define processor
#include    "p18f4550.inc"

;*****************Configuration Bits******************************
; PIC18F4550 Configuration Bit Settings

; ASM source line config statements

;#include "p18F4550.inc"

; CONFIG1L
  CONFIG  PLLDIV = 1            ; PLL Prescaler Selection bits (No prescale (4 MHz oscillator input drives PLL directly))
  CONFIG  CPUDIV = OSC1_PLL2    ; System Clock Postscaler Selection bits ([Primary Oscillator Src: /1][96 MHz PLL Src: /2])
  CONFIG  USBDIV = 1            ; USB Clock Selection bit (used in Full-Speed USB mode only; UCFG:FSEN = 1) (USB clock source comes directly from the primary oscillator block with no postscale)

; CONFIG1H
  CONFIG  FOSC = INTOSC_HS      ; Oscillator Selection bits (Internal oscillator, HS oscillator used by USB (INTHS))
  CONFIG  FCMEN = OFF           ; Fail-Safe Clock Monitor Enable bit (Fail-Safe Clock Monitor disabled)
  CONFIG  IESO = OFF            ; Internal/External Oscillator Switchover bit (Oscillator Switchover mode disabled)

; CONFIG2L
  CONFIG  PWRT = OFF            ; Power-up Timer Enable bit (PWRT disabled)
  CONFIG  BOR = OFF             ; Brown-out Reset Enable bits (Brown-out Reset disabled in hardware and software)
  CONFIG  BORV = 3              ; Brown-out Reset Voltage bits (Minimum setting 2.05V)
  CONFIG  VREGEN = OFF          ; USB Voltage Regulator Enable bit (USB voltage regulator disabled)

; CONFIG2H
  CONFIG  WDT = OFF             ; Watchdog Timer Enable bit (WDT disabled (control is placed on the SWDTEN bit))
  CONFIG  WDTPS = 32768         ; Watchdog Timer Postscale Select bits (1:32768)

; CONFIG3H
  CONFIG  CCP2MX = ON           ; CCP2 MUX bit (CCP2 input/output is multiplexed with RC1)
  CONFIG  PBADEN = OFF          ; PORTB A/D Enable bit (PORTB<4:0> pins are configured as digital I/O on Reset)
  CONFIG  LPT1OSC = OFF         ; Low-Power Timer 1 Oscillator Enable bit (Timer1 configured for higher power operation)
  CONFIG  MCLRE = ON            ; MCLR Pin Enable bit (MCLR pin enabled; RE3 input pin disabled)

; CONFIG4L
  CONFIG  STVREN = OFF          ; Stack Full/Underflow Reset Enable bit (Stack full/underflow will not cause Reset)
  CONFIG  LVP = OFF             ; Single-Supply ICSP Enable bit (Single-Supply ICSP disabled)
  CONFIG  ICPRT = OFF           ; Dedicated In-Circuit Debug/Programming Port (ICPORT) Enable bit (ICPORT disabled)
  CONFIG  XINST = OFF           ; Extended Instruction Set Enable bit (Instruction set extension and Indexed Addressing mode disabled (Legacy mode))

; CONFIG5L
  CONFIG  CP0 = OFF             ; Code Protection bit (Block 0 (000800-001FFFh) is not code-protected)
  CONFIG  CP1 = OFF             ; Code Protection bit (Block 1 (002000-003FFFh) is not code-protected)
  CONFIG  CP2 = OFF             ; Code Protection bit (Block 2 (004000-005FFFh) is not code-protected)
  CONFIG  CP3 = OFF             ; Code Protection bit (Block 3 (006000-007FFFh) is not code-protected)

; CONFIG5H
  CONFIG  CPB = OFF             ; Boot Block Code Protection bit (Boot block (000000-0007FFh) is not code-protected)
  CONFIG  CPD = OFF             ; Data EEPROM Code Protection bit (Data EEPROM is not code-protected)

; CONFIG6L
  CONFIG  WRT0 = OFF            ; Write Protection bit (Block 0 (000800-001FFFh) is not write-protected)
  CONFIG  WRT1 = OFF            ; Write Protection bit (Block 1 (002000-003FFFh) is not write-protected)
  CONFIG  WRT2 = OFF            ; Write Protection bit (Block 2 (004000-005FFFh) is not write-protected)
  CONFIG  WRT3 = OFF            ; Write Protection bit (Block 3 (006000-007FFFh) is not write-protected)

; CONFIG6H
  CONFIG  WRTC = OFF            ; Configuration Register Write Protection bit (Configuration registers (300000-3000FFh) are not write-protected)
  CONFIG  WRTB = OFF            ; Boot Block Write Protection bit (Boot block (000000-0007FFh) is not write-protected)
  CONFIG  WRTD = OFF            ; Data EEPROM Write Protection bit (Data EEPROM is not write-protected)

; CONFIG7L
  CONFIG  EBTR0 = OFF           ; Table Read Protection bit (Block 0 (000800-001FFFh) is not protected from table reads executed in other blocks)
  CONFIG  EBTR1 = OFF           ; Table Read Protection bit (Block 1 (002000-003FFFh) is not protected from table reads executed in other blocks)
  CONFIG  EBTR2 = OFF           ; Table Read Protection bit (Block 2 (004000-005FFFh) is not protected from table reads executed in other blocks)
  CONFIG  EBTR3 = OFF           ; Table Read Protection bit (Block 3 (006000-007FFFh) is not protected from table reads executed in other blocks)

; CONFIG7H
  CONFIG  EBTRB = OFF           ; Boot Block Table Read Protection bit (Boot block (000000-0007FFh) is not protected from table reads executed in other blocks)
;****************Variables Definition*********************************
GREENL		EQU	0x20
YELLOWL		EQU	0x21
REDL		EQU	0x22
BUT		EQU	0x23
;****************Main code*****************************

		ORG	0x000           ; reset vector
  		GOTO	MAIN            ; go to the main routine

INITIALIZE:
		BSF	TRISC,	0	; RC0 es input
		MOVLW	b'10000000'	; Timer0 de .524288 sec
		MOVWF	T0CON		; Habilita TOCON(timer0)
		CLRF	TRISD		; PortD output
		MOVLW	15		; Duracion del led verde
		MOVWF	GREENL		; Guarda el valor
		MOVLW	2		; Duracion del led amarillo
		MOVWF	YELLOWL		; Guarda el valor
		MOVLW	9		; Duracion del led rojo
		MOVWF	REDL		; Guarda el valor
		MOVLW	b'00010001'	; _ _ _ verde amarillo rojo peaton no peaton
		MOVWF	PORTD		; Guarda el valor in Port D
		MOVLW	3		; 3 Duracion del boton presionado
		MOVWF	BUT		; Guarda el valor
		GOTO	GREEN		; Inicializa GREEN loop

MAIN:		CALL	INITIALIZE
    
GREEND:
		DECFSZ	GREENL		; Subtracts one to GREEN
		GOTO	GREEN		; Keeps the GREEN cycle
GREENB:		MOVLW	3		; 20 times half a second for GREEN
		MOVWF	BUT		; Guarda el valor
		MOVLW	15		; 20 times half a second for GREEN
		MOVWF	GREENL		; Guarda el valor
		MOVLW	b'00000001'	; _ _ _ GREEN YELLOW RED WALK NWALK
		MOVWF	PORTD		; Guarda el valor in Port D
		GOTO	BLINK		; If 0, changes to BLINK
		
YELLOWD:
		DECFSZ	YELLOWL		; Subtracts one to YELLLOW
		GOTO	YELLOW		; Keeps the YELLOW cycle
		MOVLW	2		; 20 times half a second for YELLOW
		MOVWF	YELLOWL		; Guarda el valor
		MOVLW	b'00000110'	; _ _ _ GREEN YELLOW RED WALK NWALK
		MOVWF	PORTD		; Guarda el valor in Port D
		GOTO	RED		; If 0, changes to RED
		
REDD:
		DECFSZ	REDL		; Subtracts one to RED
		GOTO	RED		; Keeps the RED cycle
		MOVLW	9		; 20 times half a second for RED
		MOVWF	REDL		; Guarda el valor
		MOVLW	b'00010001'	; _ _ _ GREEN YELLOW RED WALK NWALK
		MOVWF	PORTD		; Guarda el valor in Port D
		GOTO	GREEN		; If 0, changes to GREEN
		
		;LOOP;	
		
GREEN:	
		BTFSC	PORTC,0		; If an imput was detected
		GOTO	BUTTON		; Button detection
		BTFSS	INTCON,2	; Waits until Timer0 reaches its limit
		GOTO	GREEN		; Loops the checking for Timer0
		BCF	INTCON,2	; Clears the timer's flag
		GOTO	GREEND		; Reduce iterations for GREEN
BLINK:
		BTFSS	INTCON,2	; Waits until Timer0 reaches its limit
		GOTO	BLINK		; Loops the checking for Timer0
		BCF	INTCON,2	; Clears the timer's flag
		MOVLW	b'00010001'	; _ _ _ GREEN YELLOW RED WALK NWALK
		MOVWF	PORTD		; Guarda el valor in Port D
BLINKON:
		BTFSS	INTCON,2	; Waits until Timer0 reaches its limit
		GOTO	BLINKON		; Loops the checking for Timer0
		BCF	INTCON,2	; Clears the timer's flag
		MOVLW	b'00000001'	; _ _ _ GREEN YELLOW RED WALK NWALK
		MOVWF	PORTD		; Guarda el valor in Port D
BLINKOFF:
		BTFSS	INTCON,2	; Waits until Timer0 reaches its limit
		GOTO	BLINKOFF	; Loops the checking for Timer0
		BCF	INTCON,2	; Clears the timer's flag
		MOVLW	b'00001001'	; _ _ _ GREEN YELLOW RED WALK NWALK
		MOVWF	PORTD		; Guarda el valor in Port D
YELLOW:
		BTFSS	INTCON,2	; Waits until Timer0 reaches its limit
		GOTO	YELLOW		; Loops the checking for Timer0
		BCF	INTCON,2	; Clears the timer's flag
		GOTO	YELLOWD		; Reduce iterations for YELLOW
RED:
		BTFSS	INTCON,2	; Waits until Timer0 reaches its limit
		GOTO	RED		; Loops the checking for Timer0
		BCF	INTCON,2	; Clears the timer's flag
		GOTO	REDD		; Reduce iterations for RED

BUTTON:
		DCFSNZ	BUT		; Subtracts one to BUT
		GOTO	GREENB		; If 3 pushes, changes
BUTTONG:	BTFSS	INTCON,2	; Waits until Timer0 reaches its limit
		GOTO	BUTTONG		; Loops the checking for Timer0
		BCF	INTCON,2	; Clears the timer's flag
BUTTONG2:	BTFSS	INTCON,2	; Waits until Timer0 reaches its limit
		GOTO	BUTTONG2	; Loops the checking for Timer0
		BCF	INTCON,2	; Clears the timer's flag
		GOTO	GREEND		; Reduce iterations for GREEN
		

		END 





