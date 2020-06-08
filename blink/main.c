#include "stm8s.h"
#include "stm8s_conf.h"
  
u16 cnt1=0;
u8  cnt2=0;

void main(void)
{
	GPIO_Init(GPIOD, GPIO_PIN_2, GPIO_MODE_OUT_PP_LOW_FAST);
    while (1) {
        cnt1++;
        if (cnt1>80000) {
            cnt1=0;
            GPIO_WriteReverse(GPIOD, GPIO_PIN_2);
 
        }
    }

}

#ifdef USE_FULL_ASSERT
void assert_failed(u8* file, u32 line)
{
  while (1)  {  }
}
#endif