#include "MKL25Z4.h"
//#include <stdio.h>
//#include "sys_clock.h"

#define DBG_MAIN_POS	1
#define DBG_ISR_POS		0
#define SW_POS			6
#define MASK(x)			(1 << x)


/* module global variable for counting interrupts*/
volatile unsigned int count;


/**
 * Interrupt handler for PORTD
 * */
void PORTD_IRQHandler(void)
{
    // TODO set debug pin high
    // PORTD to Port-Set-Output-Register
	// bitwise or
	GPIOD->PSOR |= MASK(DBG_ISR_POS);

	NVIC_ClearPendingIRQ(PORTD_IRQn);
	if ((PORTD->ISFR & MASK(SW_POS)))
	{
		count++;
	}
	/* clear status flags */
	PORTD->ISFR = 0xffffffff;

    //
    // TODO clear debug pin
    // PCOR = port clear output register
	GPIOD->PCOR |= MASK(DBG_ISR_POS);
}

int main(int argc, char *argv[]) {
  int a = 0;
  int k = 2;
  int b = a + k;
  while (1)
    _ASM("NOP");
	return 0;
}
