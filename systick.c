#include "systick.h"
#define CTRL_ENABLE 	(1U<<0)
#define CTRL_CLKSRC 	(1U<<2)
void systick_counter_init(void){
	/*Disable systick before config*/
	SysTick->CTRL = 0;
	/*Load systick rekoad value register with the maximum value*/
	SysTick->LOAD = 0x00FFFFFF;
	/*Clear systick current value register*/
	SysTick->VAL = 0;
	/*select internal clock source*/
	SysTick->CTRL |= CTRL_CLKSRC;
	/*Enable Systick*/
	SysTick->CTRL |= CTRL_ENABLE;
}
