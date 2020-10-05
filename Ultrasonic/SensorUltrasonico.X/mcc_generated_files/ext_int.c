/**
   EXT_INT Generated Driver File
 
   @Company
     Microchip Technology Inc.
 
   @File Name
     ext_int.c
 
   @Summary
     This is the generated driver implementation file for the EXT_INT driver using PIC10 / PIC12 / PIC16 / PIC18 MCUs
 
   @Description
     This source file provides implementations for driver APIs for EXT_INT.
     Generation Information :
         Product Revision  :  PIC10 / PIC12 / PIC16 / PIC18 MCUs - 1.81.5
         Device            :  PIC18F45K50
         Driver Version    :  1.11
     The generated drivers are tested against the following:
         Compiler          :  XC8 2.20 and above
         MPLAB             :  MPLAB X 5.40
 */ 

 /**
   Section: Includes
 */
#include <xc.h>
#include "ext_int.h"
#include "tmr0.h"
#include "mcc.h"

void (*INT0_InterruptHandler)(void);
void (*INT1_InterruptHandler)(void);

void INT0_ISR(void)
{
    EXT_INT0_InterruptFlagClear();

    // Callback function gets called everytime this ISR executes
    INT0_CallBack();    
}


void INT0_CallBack(void)
{
    // Add your custom callback code here
    if(INT0_InterruptHandler)
    {
        INT0_InterruptHandler();
    }
}

void INT0_SetInterruptHandler(void (* InterruptHandler)(void)){
    INT0_InterruptHandler = InterruptHandler;
}

void INT0_DefaultInterruptHandler(void){
    // Initialize timer
    TMR0_StartTimer();
}
void INT1_ISR(void)
{
    EXT_INT1_InterruptFlagClear();

    // Callback function gets called everytime this ISR executes
    INT1_CallBack();    
}


void INT1_CallBack(void)
{
    // Add your custom callback code here
    if(INT1_InterruptHandler)
    {
        INT1_InterruptHandler();
    }
}

void INT1_SetInterruptHandler(void (* InterruptHandler)(void)){
    INT1_InterruptHandler = InterruptHandler;
}

void INT1_DefaultInterruptHandler(void){
    TMR0_StopTimer();                   // Detiene el contador
    distancia = TMR0_ReadTimer()/58;    // Se hace la operación para tener la distancia
    decena = distancia/10;              // Decena obtenida con una división
    unidad = distancia-(decena*10);     // La unidad se obtiene de la resta con la decena                           
    decimal = (distancia-(float)(decena*10+unidad))*10;  // Las decimales se resta el entero
    TMR0_Reload();                      // Se recarga el tiempo
    enabletrigger = 1;                  // Activate el enabletrigger
}

void EXT_INT_Initialize(void)
{
    
    // Clear the interrupt flag
    // Set the external interrupt edge detect
    EXT_INT0_InterruptFlagClear();   
    EXT_INT0_risingEdgeSet();    
    // Set Default Interrupt Handler
    INT0_SetInterruptHandler(INT0_DefaultInterruptHandler);
    EXT_INT0_InterruptEnable();      

    
    // Clear the interrupt flag
    // Set the external interrupt edge detect
    EXT_INT1_InterruptFlagClear();   
    EXT_INT1_fallingEdgeSet();    
    // Set Default Interrupt Handler
    INT1_SetInterruptHandler(INT1_DefaultInterruptHandler);
    EXT_INT1_InterruptEnable();      

}

