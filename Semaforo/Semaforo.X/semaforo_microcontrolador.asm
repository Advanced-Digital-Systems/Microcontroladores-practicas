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
DURACIONVERDE		EQU	0x14
DURACIONAMARILLO	EQU	0x15
DURACIONROJO		EQU	0x16
DURACIONBOTON		EQU	0x17
;****************Main code*****************************

		ORG	0x000           ; reset vector
  		GOTO	MAIN            ; go to the main routine

INITIALIZE:
		BSF	TRISC,	0	; RC0 es input
		MOVLW	b'10000000'	; Timer0 de .524288 sec
		MOVWF	T0CON		; Habilita TOCON(timer0)
		CLRF	TRISD		; PortD output
		MOVLW	15		; Duracion del led verde
		MOVWF	DURACIONVERDE		; Guarda el valor
		MOVLW	2		; Duracion del led amarillo
		MOVWF	DURACIONAMARILLO		; Guarda el valor
		MOVLW	9		; Duracion del led rojo
		MOVWF	DURACIONROJO		; Guarda el valor
		MOVLW	b'00010001'	; _ _ _ verde amarillo rojo peaton no peaton
		MOVWF	PORTD		; Guarda el valor in Port D
		MOVLW	3		; 3 Duracion del boton presionado
		MOVWF	DURACIONBOTON		; Guarda el valor
		GOTO	SEMAFOROVERDE		; Inicializa SEMAFOROVERDE loop

MAIN:		CALL	INITIALIZE
    	
SEMAFOROVERDE:	
		BTFSC	PORTC,0		; If an imput was detected
		GOTO	BOTON		; Button detection
		BTFSS	INTCON,2	; Waits until Timer0 reaches its limit
		GOTO	SEMAFOROVERDE		; Loops the checking for Timer0
		BCF	INTCON,2	; Clears the timer's flag
		GOTO	DECREMENTOVERDE		; Reduce iterations for VERDE
PARPADEO:
		BTFSS	INTCON,2	; Waits until Timer0 reaches its limit
		GOTO	PARPADEO		; Loops the checking for Timer0
		BCF	INTCON,2	; Clears the timer's flag
		MOVLW	b'00010001'	; _ _ _ SEMAFOROVERDE SEMAFOROAMARILLO SEMAFOROROJO WALK NWALK
		MOVWF	PORTD		; Guarda el valor in Port D
PARPADEOPRENDIDO:
		BTFSS	INTCON,2	; Waits until Timer0 reaches its limit
		GOTO	PARPADEOPRENDIDO		; Loops the checking for Timer0
		BCF	INTCON,2	; Clears the timer's flag
		MOVLW	b'00000001'	; _ _ _ SEMAFOROVERDE SEMAFOROAMARILLO SEMAFOROROJO WALK NWALK
		MOVWF	PORTD		; Guarda el valor in Port D
PARPADEOAPAGADO:
		BTFSS	INTCON,2	; Waits until Timer0 reaches its limit
		GOTO	PARPADEOAPAGADO	; Loops the checking for Timer0
		BCF	INTCON,2	; Clears the timer's flag
		MOVLW	b'00001001'	; _ _ _ SEMAFOROVERDE SEMAFOROAMARILLO SEMAFOROROJO WALK NWALK
		MOVWF	PORTD		; Guarda el valor in Port D
SEMAFOROAMARILLO:
		BTFSS	INTCON,2	; Waits until Timer0 reaches its limit
		GOTO	SEMAFOROAMARILLO		; Loops the checking for Timer0
		BCF	INTCON,2	; Clears the timer's flag
		GOTO	DECREMENTOAMARILLO		; Reduce iterations for SEMAFOROAMARILLO
SEMAFOROROJO:
		BTFSS	INTCON,2	; Waits until Timer0 reaches its limit
		GOTO	SEMAFOROROJO		; Loops the checking for Timer0
		BCF	INTCON,2	; Clears the timer's flag
		GOTO	DECREMENTOROJO		; Reduce iterations for SEMAFOROROJO

BOTON:
		DCFSNZ	DURACIONBOTON		; Subtracts one to BUT
		GOTO	GUARDAVERDE		; If 3 pushes, changes
BOTON1:		BTFSS	INTCON,2	; Waits until Timer0 reaches its limit
		GOTO	BOTON1		; Loops the checking for Timer0
		BCF	INTCON,2	; Clears the timer's flag
BOTON2:		BTFSS	INTCON,2	; Waits until Timer0 reaches its limit
		GOTO	BOTON2	; Loops the checking for Timer0
		BCF	INTCON,2	; Clears the timer's flag
		GOTO	DECREMENTOVERDE		; Reduce iterations for VERDE


DECREMENTOVERDE:
		DECFSZ	DURACIONVERDE		; Subtracts one to VERDE
		GOTO	SEMAFOROVERDE		; Keeps the VERDE cycle
GUARDAVERDE:	MOVLW	3		; 20 times half a second for VERDE
		MOVWF	DURACIONBOTON		; Guarda el valor
		MOVLW	15		; 20 times half a second for VERDE
		MOVWF	DURACIONVERDE		; Guarda el valor
		MOVLW	b'00000001'	; _ _ _ VERDE SEMAFOROAMARILLO SEMAFOROROJO WALK NWALK
		MOVWF	PORTD		; Guarda el valor in Port D
		GOTO	PARPADEO		; If 0, changes to PARPADEO
		
DECREMENTOAMARILLO:
		DECFSZ	DURACIONAMARILLO		; Subtracts one to YELLLOW
		GOTO	SEMAFOROAMARILLO		; Keeps the SEMAFOROAMARILLO cycle
		MOVLW	2		; 20 times half a second for SEMAFOROAMARILLO
		MOVWF	DURACIONAMARILLO		; Guarda el valor
		MOVLW	b'00000110'	; _ _ _ VERDE SEMAFOROAMARILLO SEMAFOROROJO WALK NWALK
		MOVWF	PORTD		; Guarda el valor in Port D
		GOTO	SEMAFOROROJO		; If 0, changes to SEMAFOROROJO
		
DECREMENTOROJO:
		DECFSZ	DURACIONROJO		; Subtracts one to SEMAFOROROJO
		GOTO	SEMAFOROROJO		; Keeps the SEMAFOROROJO cycle
		MOVLW	9		; 20 times half a second for SEMAFOROROJO
		MOVWF	DURACIONROJO		; Guarda el valor
		MOVLW	b'00010001'	; _ _ _ VERDE SEMAFOROAMARILLO SEMAFOROROJO WALK NWALK
		MOVWF	PORTD		; Guarda el valor in Port D
		GOTO	SEMAFOROVERDE		; If 0, changes to SEMAFOROVERDE
	

		END 





