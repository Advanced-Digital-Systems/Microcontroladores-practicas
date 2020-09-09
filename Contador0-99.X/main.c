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
        Product Revision  :  PIC10 / PIC12 / PIC16 / PIC18 MCUs - 1.81.4
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
                         Main application
 */


void start_contador();
void reset_contador();
void stop_contador();
void segundo();
void prender_num(int);
void prender_num_2(int);

void main(void)
{
    // Initialize the device
    SYSTEM_Initialize();

    // If using interrupts in PIC18 High/Low Priority Mode you need to enable the Global High and Low Interrupts
    // If using interrupts in PIC Mid-Range Compatibility Mode you need to enable the Global and Peripheral Interrupts
    // Use the following macros to:

    // Enable the Global Interrupts
    //INTERRUPT_GlobalInterruptEnable();

    // Disable the Global Interrupts
    //INTERRUPT_GlobalInterruptDisable();

    // Enable the Peripheral Interrupts
    //INTERRUPT_PeripheralInterruptEnable();

    // Disable the Peripheral Interrupts
    //INTERRUPT_PeripheralInterruptDisable();

    while (1)
    {
        
        if(IO_RC0_GetValue() == 1)
    {
        start_contador();
    }
        else if(IO_RC1_GetValue() == 1)
    {
        reset_contador();
    }
        else if(IO_RC2_GetValue() == 1)
    {
        stop_contador();
    }
    }
}

void segundo(){
    bool bandera = false;
    TMR0_StartTimer();
    while(TMR0_ReadTimer() != 255){
        bandera = false;
    }
    bandera = true;
}

void start_contador(){
    for(int j = 0; j < 10; j++){
        prender_num_2(j);
        for(int i = 0; i < 10; i++){
            prender_num(i);
            segundo();
            TMR0_Reload(); 
        }
    }
    reset_contador();
}

void reset_contador(){
    stop_contador();
    PORTB = 0B00111111;
    PORTD = 0B00111111;
}

void stop_contador(){
    
}

void  prender_num(int num){
    switch(num) {
        case 0:
            PORTB = 0B00111111;
            break;
        case 1:
            PORTB = 0B00000110;
            break;
        case 2:
            PORTB = 0B01011011;
            break;
        case 3:
            PORTB = 0B01001111;
            break;
        case 4:
            PORTB = 0B01100110;
            break;
        case 5:
            PORTB = 0B01101101;
            break;
        case 6:
            PORTB = 0B01111101;
            break;
        case 7:
            PORTB = 0B00000111;
            break;
        case 8:
            PORTB = 0B01111111;
            break;
        case 9:
            PORTB = 0B01100111;
            break;
    }
}

void  prender_num_2(int num){
    switch(num) {
        case 0:
            PORTD = 0B00111111;
            break;
        case 1:
            PORTD = 0B00000110;
            break;
        case 2:
            PORTD = 0B01011011;
            break;
        case 3:
            PORTD = 0B01001111;
            break;
        case 4:
            PORTD = 0B01100110;
            break;
        case 5:
            PORTD = 0B01101101;
            break;
        case 6:
            PORTD = 0B01111101;
            break;
        case 7:
            PORTD = 0B00000111;
            break;
        case 8:
            PORTD = 0B01111111;
            break;
        case 9:
            PORTD = 0B01100111;
            break;
    }
}
/**
 End of File
*/