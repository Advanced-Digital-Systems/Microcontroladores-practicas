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
void delay_ms(int delay);

/*
                         Main application
 */
void display(int);
void display(int num){
    // Asigna los valores del PortD de acuerdo a los numeros enteros
    switch(num){
        case 0:
            PORTD = 0b01111110;
            break;
        case 1:
            PORTD = 0b00110000;
            break;
        case 2:
            PORTD = 0b01101101;
            break;
        case 3:
            PORTD = 0b01111001;
            break;
        case 4:
            PORTD = 0b00110011;
            break;
        case 5:
            PORTD = 0b01011011;
            break;
        case 6:
            PORTD = 0b01011111;
            break;
        case 7:
            PORTD = 0b01110000;
            break;
        case 8:
            PORTD = 0b01111111;
            break;
        case 9:
            PORTD = 0b01111011;
            break;
    }
}
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

    // Start program
    IO_RB3_SetHigh();           // Activate sensor
    __delay_us(10);             // Requires 10 us
    IO_RB3_SetLow();            // Turn off the activator
    
    while (1)
    {
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
            PORTB = 0b00010000;                   // Activa el display de decenas
            display(9);                    // Imprime decenas
            __delay_ms(10); 
            PORTB = 0b00000000;
            __delay_ms(10); 
            PORTB = 0b00100000;                // Activa display de unidades
            display(8);                   // Imprime unidades
             __delay_ms(10);   
            PORTB = 0b00000000;
            __delay_ms(10);
            PORTB = 0b01000000;                  // Activa display decimales
            display(1);                 // Imprime decimales
            __delay_ms(10); 
            PORTB = 0b00000000;
            __delay_ms(10);
            IO_RC2_SetHigh(); 
            IO_RC6_SetHigh(); 
        }
        // If triggerFlag is on
        if(triggerFlag){
            IO_RB3_SetHigh();           // Activate sensor
            __delay_us(10);             // Requires 10 us
            IO_RB3_SetLow();            // Turn off the activator
            
            triggerFlag = 0;            // Turn of flag
        }
    }
}

// Function delay_ms that applies variable delays
void delay_ms(int delay)
{
    // While delay value is positive
    while(delay > 0)
    {
        __delay_ms(1);                  // Constant delay of 1 ms
        delay--;                        // Subtract by one the delay value
    }
}
/**
 End of File
*/