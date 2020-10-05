#include "mcc_generated_files/mcc.h"
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
    IO_RB2_SetHigh();           // Activa el Trigger
    __delay_us(10);             // Toma 10us de delay
    IO_RB2_SetLow();            // Apaga el Trigger
    
    while (1)
    {
        PORTC = 0b00000001;                   // Activa el display de decenas
        display(decena);                    // Imprime decenas
        __delay_ms(10); 
        PORTD = 0b00000000;
        __delay_ms(10); 
        PORTC = 0b00000010;                // Activa display de unidades
        display(unidad);                   // Imprime unidades
         __delay_ms(10);   
        PORTD = 0b00000000;
        __delay_ms(10);
        PORTC = 0b00000100;                  // Activa display decimales
        display(decimal);                 // Imprime decimales
        __delay_ms(10); 
        PORTD = 0b00000000;
        __delay_ms(10);
        if(enabletrigger){                // Si el enabletrigger esta activo 
            __delay_ms(10);             
            IO_RB2_SetHigh();           // Activa el Trigger
            __delay_us(10);             // Toma 10us de delay
            IO_RB2_SetLow();            // Apaga el Trigger
            
            enabletrigger = 0;            // Apaga la bandera
        }
    }
}

/**
 End of File
*/