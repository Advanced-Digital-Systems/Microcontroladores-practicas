/**
  Generated Main Source File

  Company:
    Microchip Technology Inc.

  File Name:
    main.c

  Summary:
    This is the main file generated using PIC10 / PIC12 / PIC16 / PIC18 MCUs

  Description:
    This header file provides implementations for driver APIs for all modules selected in the GUI.
    Generation Information :
        Product Revision  :  PIC10 / PIC12 / PIC16 / PIC18 MCUs - 1.81.6
        Device            :  PIC18F45K50
        Driver Version    :  2.00
*/

/*
    (c) 2018 Microchip Technology Inc. and its subsidiaries. 
    
    Subject to your compliance with these terms, you may use Microchip software and any 
    derivatives exclusively with Microchip products. It is your responsibility to comply with third party 
    license terms applicable to your use of third party software (including open source software) that 
    may accompany Microchip software.
    
    THIS SOFTWARE IS SUPPLIED BY MICROCHIP "AS IS". NO WARRANTIES, WHETHER 
    EXPRESS, IMPLIED OR STATUTORY, APPLY TO THIS SOFTWARE, INCLUDING ANY 
    IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY, AND FITNESS 
    FOR A PARTICULAR PURPOSE.
    
    IN NO EVENT WILL MICROCHIP BE LIABLE FOR ANY INDIRECT, SPECIAL, PUNITIVE, 
    INCIDENTAL OR CONSEQUENTIAL LOSS, DAMAGE, COST OR EXPENSE OF ANY KIND 
    WHATSOEVER RELATED TO THE SOFTWARE, HOWEVER CAUSED, EVEN IF MICROCHIP 
    HAS BEEN ADVISED OF THE POSSIBILITY OR THE DAMAGES ARE FORESEEABLE. TO 
    THE FULLEST EXTENT ALLOWED BY LAW, MICROCHIP'S TOTAL LIABILITY ON ALL 
    CLAIMS IN ANY WAY RELATED TO THIS SOFTWARE WILL NOT EXCEED THE AMOUNT 
    OF FEES, IF ANY, THAT YOU HAVE PAID DIRECTLY TO MICROCHIP FOR THIS 
    SOFTWARE.
*/

#include "mcc_generated_files/mcc.h"
/*
 *              Funciones que operan el servo motor
 */

void display(int);
void display(int disp){
    // Asigna valores al display 
    switch(disp){
        case 0:
            PORTA = 0b01111110;
            break;
        case 1:
            PORTA = 0b00110000;
            break;
        case 2:
            PORTA = 0b01101101;
            break;
        case 3:
            PORTA = 0b01111001;
            break;
        case 4:
            PORTA = 0b00110011;
            break;
        case 5:
            PORTA = 0b01011011;
            break;
        case 6:
            PORTA = 0b01011111;
            break;
        case 7:
            PORTA = 0b01110000;
            break;
        case 8:
            PORTA = 0b01111111;
            break;
        case 9:
            PORTA = 0b01111011;
            break;
    }
}
/*
                         Main application
 */
void main(void)
{
    // Initialize the device
    SYSTEM_Initialize();

    // If using interrupts in PIC18 High/Low Priority Mode you need to enable the Global High and Low Interrupts
    // If using interrupts in PIC Mid-Range Compatibility Mode you need to enable the Global and Peripheral Interrupts
    // Use the following macros to:

    // Enable the Global Interrupts
    INTERRUPT_GlobalInterruptEnable();

    // Disable the Global Interrupts
    //INTERRUPT_GlobalInterruptDisable();

    // Enable the Peripheral Interrupts
    INTERRUPT_PeripheralInterruptEnable();

    // Disable the Peripheral Interrupts
    //INTERRUPT_PeripheralInterruptDisable();
    PORTD = 0xF;
    while (1)
    {
        // Este es el la funcion que hace reconocer que boton es presionado
        if(button){
            // Si el puerto B sigue encendido la fila presionada es la activa
            PORTD = 0x1;
            if(PORTB){
                row = 0;
            }
            PORTD = 0x2;
            if(PORTB){
                row = 1;
            }
            PORTD = 0x4;
            if(PORTB){
                row = 2; 
            }
            PORTD = 0x8;
            if(PORTB){
                row = 3;
            }
            PORTD = 0xF;
            
            // Por default la contraseña está correcta, pero esto puede cambiar a falso en cualquier etapa.
            count++; // Se incrementa el conteo, para darle seguimiento a la secuencia
            
            // Si se presiona # se resetea todo
            if (keypad[row][col] == '#') { 
                count = 0;
                correct = true;
            }
            //Aqui se revisara cada digito para eso el count++ para revisar que se presionen los 4 numeros del codigo.
            // Revisa cada caracter uno por uno empezando por el primero y si es incorrecto marca false antes de ir al siguiente caracter,
            if (count == 1) {
                if(!(keypad[row][col] == primer)) {
                    correct = false;
                }
            } else if (count == 2) {
                if(!(keypad[row][col] == segundo)) {
                    correct = false;
                }
            } else if (count == 3) {
                if(!(keypad[row][col] == tercero)) {
                    correct = false;
                }
            } else if (count == 4) {
                if(!(keypad[row][col] == cuarto)) {
                    correct = false;
                }
                //Si la contraseña es correcta se muestra en el display que si lo es, suena el boozer y se enciende el led verde.
                if(correct == true) {
                    PORTE = 0b0001;             // Activa el display de decenas
                    display(1);                    // Imprime decenas
                    IO_RC2_SetHigh();
                    IO_RC6_SetHigh();
                    __delay_ms(3000);
                    IO_RC2_SetLow();
                    IO_RC6_SetLow();  
                    PORTE = 0b0000;
                // Si la contraseña es incorrecta, se activa el buzzer (alarma) y se enciende el led rojo y el display mostrando error
                } else {
                    PORTE = 0b0001;             // Activa el display de decenas
                    display(0);                    // Imprime decenas
                    IO_RC0_SetHigh();           // Turn on LED
                    IO_RC1_SetHigh();           // Turn on Buzzer
                    __delay_ms(3000);            // Constant delay of 250 ms
                    IO_RC0_SetLow();            // Turn off LED
                    IO_RC1_SetLow();            // Turn off Buzzer              
                    PORTE = 0b0000;
                    
                    correct = true;
                }
                count = 0;
            }
            button = false;
        }        
    }
}

/**
 End of File
*/