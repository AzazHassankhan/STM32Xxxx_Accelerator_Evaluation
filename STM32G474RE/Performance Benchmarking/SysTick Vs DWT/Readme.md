# SysTick Vs DWT

### Results:
![image](https://github.com/AzazHassankhan/STM32Xxxx_Accelerator_Evaluation/assets/92155897/5a601ba2-1a74-417c-b77f-b72ab2b3bf59)

### Conclutions:
1. Systick introduces significant overhead as the calculation time increases.
2. Systick interferes with the rest of the system due to its interrupt-based calculation technique.
3. With Systick, you can only calculate precision up to milliseconds.
4. Changing the setting from 1 millisecond to microseconds will halt the rest of the system.
5. With DWT, you can calculate precision up to Nanoseconds.
6. DWT doesn’t interferes with rest of the system.
