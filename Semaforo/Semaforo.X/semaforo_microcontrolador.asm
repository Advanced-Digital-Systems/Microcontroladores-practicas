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

		ORG	0x000           
  		GOTO	MAIN            ; Inicia en el Main

INITIALIZE:
		BSF	TRISC,	0	; Define RC0 como una entrada
		MOVLW	b'10000000'	; Define el valor del timer como .524288 segundos
		MOVWF	T0CON		; Habilita e inicializa el timer 
		CLRF	TRISD		; Define todo el puero D como salida
		MOVLW	15		; Define la duración del led verde
		MOVWF	DURACIONVERDE	; Guarde el valor de duración en DURACIONVERDE
		MOVLW	2		; Define la duración del led verde
		MOVWF	DURACIONAMARILLO; Guarda el valor de duración en DURACIONAMARILLO
		MOVLW	9		; Define la duración del led rojo
		MOVWF	DURACIONROJO	; Guarda el valor de duración en DURACIONROJO
		MOVLW	b'00010001'	; Prende rojo para peatones y verde para autos
		MOVWF	PORTD		; Lo guarda en Puerto D
		MOVLW	3		; Establece cuánto tiempo tiene que ser presionado el botón
		MOVWF	DURACIONBOTON	; Guarda el valor de 3 segundos en DURACIONBOTON
		GOTO	SEMAFOROVERDE	; Llama a SEMAFOROVERDE

MAIN:		CALL	INITIALIZE
    	
SEMAFOROVERDE:	
		BTFSC	PORTC,0		; Verifica si hay una entrada
		GOTO	BOTON		; En caso de que haya una entrada, llama a BOTON
		BTFSS	INTCON,2	
		GOTO	SEMAFOROVERDE	; Vuelve al ciclo para el timer 
		BCF	INTCON,2	; Reinicia cuenta del timer  
		GOTO	DECREMENTOVERDE	; Llama a DECREMENTOVERDE
PARPADEO:
		BTFSS	INTCON,2	; Espera a que el timer se desborde
		GOTO	PARPADEO	; Llama a PARPADEO
		BCF	INTCON,2	; Reinicia cuenta del timer  
		MOVLW	b'00010001'	; Prende el rojo para peatones y verde para autos
		MOVWF	PORTD		; Guarda el valor en el puerto D
PARPADEOPRENDIDO:
		BTFSS	INTCON,2	; Espera a que el timer se desborde
		GOTO	PARPADEOPRENDIDO; llama a PARPADEOPRENDIDO
		BCF	INTCON,2	; Reinicia cuenta del timer  
		MOVLW	b'00000001'	; Prender rojo el peatonal y apaga el verde para autos
		MOVWF	PORTD		; Guarda el valor in Port D
PARPADEOAPAGADO:
		BTFSS	INTCON,2	; Espera a que el timer se desborde
		GOTO	PARPADEOAPAGADO	; 
		BCF	INTCON,2	; Reinicia cuenta del timer  
		MOVLW	b'00001001'	; Prende rojo peatonal y prende amarillo para autos
		MOVWF	PORTD		; Guarda el valor in Port D
SEMAFOROAMARILLO:
		BTFSS	INTCON,2	   ; Espera a que el timer se desborde
		GOTO	SEMAFOROAMARILLO   ; Vuelve al ciclo para el timer 
		BCF	INTCON,2	   ; Reinicia cuenta del timer  
		GOTO	DECREMENTOAMARILLO ; Resta uno al contador de ciclos
SEMAFOROROJO:
		BTFSS	INTCON,2	; Espera a que el timer se desborde
		GOTO	SEMAFOROROJO	; Vuelve al ciclo para el timer 
		BCF	INTCON,2	; Reinicia cuenta del timer  
		GOTO	DECREMENTOROJO	; Resta uno al contador de ciclos

BOTON:
		DCFSNZ	DURACIONBOTON	; Le resta uno a DURACIONBOTON
		GOTO	GUARDAVERDE	; Si es presionado 3 veces entra
BOTON1:		BTFSS	INTCON,2	; Espera a que el timer se desborde
		GOTO	BOTON1		; Vuelve al ciclo para verificar el timer
		BCF	INTCON,2	; Reinicia cuenta del timer  
BOTON2:		BTFSS	INTCON,2	; Espera a que el timer se desborde
		GOTO	BOTON2	        ; Vuelve al ciclo para verificar el timer
		BCF	INTCON,2	; Reinicia cuenta del timer  
		GOTO	DECREMENTOVERDE	; Resta uno al contador de ciclos 


DECREMENTOVERDE:
		DECFSZ	DURACIONVERDE		; Resta uno al contador 
		GOTO	SEMAFOROVERDE		; Vuelve a SEMAFOROVERDE
GUARDAVERDE:	MOVLW	3		        ; 20 veces por cada segundo en SEMAFOROVERDE
		MOVWF	DURACIONBOTON		; Guarda el valor
		MOVLW	15		        ; 20 times half a second for VERDE
		MOVWF	DURACIONVERDE		; Guarda el valor
		MOVLW	b'00000001'	        ; Prende rojo para peatones y apaga amarillo para autos
		MOVWF	PORTD		        ; Guarda el valor en el Puerto D
		GOTO	PARPADEO	 	; Si el valor es 0, va a PARPADEO
		
DECREMENTOAMARILLO:
		DECFSZ	DURACIONAMARILLO	; Resta uno al contador 
		GOTO	SEMAFOROAMARILLO	; Vuelve a SEMAFOROAMARILLO
		MOVLW	2		        ; 20 veces por cada segundo en SEMAFOROAMARILLO
		MOVWF	DURACIONAMARILLO	; Guarda el valor
		MOVLW	b'00000110'	        ; Verde para peatones y rojo autos
		MOVWF	PORTD		        ; Guarda el valor el puerto D
		GOTO	SEMAFOROROJO	 	; Si el valor es 0, va a SEMAFOROJO
		
DECREMENTOROJO:
		DECFSZ	DURACIONROJO		; Resta uno al contador de ciclo
		GOTO	SEMAFOROROJO		; Vuelve a semáforo rojo
		MOVLW	9		        ; 20 veces por cada segundo en SEMAFOROROJO
		MOVWF	DURACIONROJO		; Guarda el valor
		MOVLW	b'00010001'	        ; Rojo para peatones y verde autos
		MOVWF	PORTD		        ; Guarda el valor en el puerto D
		GOTO	SEMAFOROVERDE		; Si es 0, regresa a SEMAFOROVERDE
	

		END 





