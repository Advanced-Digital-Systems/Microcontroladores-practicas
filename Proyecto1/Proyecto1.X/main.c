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
void display(int num){
    // Asigna los valores del PortD de acuerdo a los numeros enteros
    switch(num){
        case 0:
            PORTA = 0b01111110;
            break;
        case 1:
<<<<<<< HEAD
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
=======
            PORTD = 0b01011011;
            break;
        case 2:
            PORTD = 0b00010111;
            break;
        case 3:
            PORTD = 0b01111110;
            break;
        case 4:
            PORTD = 0b00000000;
>>>>>>> 7a45ca942df585b296e2372ced734b251f48bbd8
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
<<<<<<< HEAD
            PORTA = 0b01111111;
            break;
        case 9:
            PORTA = 0b01111011;
=======
            PORTD = 0b01001111;
            break;
        case 9:
            PORTD = 0b00110011;
>>>>>>> 7a45ca942df585b296e2372ced734b251f48bbd8
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
<<<<<<< HEAD
        // Si un botón ha sido presionado, se inicia un scaneo cambiando el valor del puerto B para detectar la fila que se presionó
        if(button_pressed){
            // Si el puerto B sigue encendido cuando solo está activa la fila 0, esa es la fila presionada
            PORTD = 0x1;
            if(PORTB){
                row = 0;
            }
            // Si el puerto B sigue encendido cuando solo está activa la fila 1, esa es la fila presionada
            PORTD = 0x2;
            if(PORTB){
                row = 1;
            }
            // Si el puerto B sigue encendido cuando solo está activa la fila 2, esa es la fila presionada
            PORTD = 0x4;
            if(PORTB){
                row = 2;
            }
            // Si el puerto B sigue encendido cuando solo está activa la fila 3, esa es la fila presionada
            PORTD = 0x8;
            if(PORTB){
                row = 3;
            }
            PORTD = 0xF;
            
            // Se checa el conteo de los botones presionados (máximo 4, porque la contraseña es de 4 caracteres) para comparar la entrada a la contraseña correcta al final
            // Por default la contraseña está correcta, pero esto puede cambiar a falso en cualquier etapa.
            count++; // Se incrementa el conteo, para darle seguimiento a la secuencia
=======
        // If the distance is less than 40 cm
        if(distance < 40){
            IO_RC2_SetLow();
            IO_RC6_SetLow();
            IO_RC0_SetHigh();           // Turn on LED
            IO_RC1_SetHigh();           // Turn on Buzzer
            __delay_ms(250);            // Constant delay of 250 ms
            IO_RC0_SetLow();            // Turn off LED
            IO_RC1_SetLow();            // Turn off Buzzer
            delay_ms(distance*2000/40);    // Distance variable delay
        }
        else{
            //aqui debe haber un if donde se haga la comparación
            PORTB = 0b00000000;
            PORTB = 0b00010000;                   // Activa el display de decenas
            display(9);                    // Imprime decenas 
            __delay_ms(10);
            PORTB = 0b00000000;
            PORTB = 0b00100000;                // Activa display de unidades
            display(8);                   // Imprime unidades
            __delay_ms(10);   
            PORTB = 0b00000000;
            PORTB = 0b01000000;                  // Activa display decimales
            display(1);                 // Imprime decimales
            __delay_ms(10); 
            //PORTB = 0b00000000;
            IO_RC2_SetHigh(); 
            IO_RC6_SetHigh(); 
            
            //aqui se hace el else del if 
            PORTB = 0b00000000;
            PORTB = 0b00010000;                   // Activa el display de decenas
            display(2);                    // Imprime decenas
            __delay_ms(10);
            PORTB = 0b00000000;
            PORTB = 0b00100000;                // Activa display de unidades
            display(3);                   // Imprime unidades
             __delay_ms(10);
            PORTB = 0b00000000;
            PORTB = 0b01000000;                  // Activa display decimales
            display(4);                 // Imprime decimales
            __delay_ms(10);
            
        }
        // If triggerFlag is on
        if(triggerFlag){
            IO_RB3_SetHigh();           // Activate sensor
            __delay_us(10);             // Requires 10 us
            IO_RB3_SetLow();            // Turn off the activator
>>>>>>> 7a45ca942df585b296e2372ced734b251f48bbd8
            
            // Si se presionó '#', se resetea el conteo y se empieza de nuevo la lectura de la contraseña
            if (keypad[row][col] == '#') { 
                count = 0;
                correct_password = true;
            }
            // La 1ra vez que se presiona el botón, se decide que la contraseña es incorrecta si no hay match con el 1er caracter
            if (count == 1) {
                if(!(keypad[row][col] == password_first)) {
                    correct_password = false;
                }
            // La 2da vez que se presiona el botón, se decide que la contraseña es incorrecta si no hay match con el 2do caracter
            } else if (count == 2) {
                if(!(keypad[row][col] == password_second)) {
                    correct_password = false;
                }
            // La 3ra vez que se presiona el botón, se decide que la contraseña es incorrecta si no hay match con el 3er caracter
            } else if (count == 3) {
                if(!(keypad[row][col] == password_third)) {
                    correct_password = false;
                }
            // La 4ta vez que se presiona el botón, se decide que la contraseña es incorrecta si no hay match con el 4to caracter
            // Después, se checa si hasta este punto la contraseña es correcta o falsa (y se decide la salida del sistema)
            } else if (count == 4) {
                if(!(keypad[row][col] == password_fourth)) {
                    correct_password = false;
                }
                // Si la contraseña es correcta, se abre y se cierra el servo (caja fuerte)
                if(correct_password == true) {
                    PORTE = 0b0001;             // Activa el display de decenas
                    display(1);                    // Imprime decenas
                    IO_RC2_SetHigh();
                    IO_RC6_SetHigh();
                    __delay_ms(3000);
                    IO_RC2_SetLow();
                    IO_RC6_SetLow();  
                    PORTE = 0b0000;
                // Si la contraseña es incorrecta, se activa el buzzer (alarma) y se cambia el valor de correct_password a true para reiniciar la lectura
                } else {
                    PORTE = 0b0001;             // Activa el display de decenas
                    display(0);                    // Imprime decenas
                    IO_RC0_SetHigh();           // Turn on LED
                    IO_RC1_SetHigh();           // Turn on Buzzer
                    __delay_ms(3000);            // Constant delay of 250 ms
                    IO_RC0_SetLow();            // Turn off LED
                    IO_RC1_SetLow();            // Turn off Buzzer              
                    PORTE = 0b0000;
                    
                    correct_password = true;
                }
                count = 0;
            }
            button_pressed = false;
        }        
    }
}

/**
 End of File
*/