# SystemClock_Config
## System Clock Configuration

@ `Core/Src/main.c`

```c
/**
  * @brief System Clock Configuration
  * @retval None
  */
void SystemClock_Config(void)
{
```

```c
  RCC_OscInitTypeDef RCC_OscInitStruct = {0};
  RCC_ClkInitTypeDef RCC_ClkInitStruct = {0};
```
- [[RCC_OscInitTypeDef]]
	- [[RCC_OscInitStruct]]
- [[RCC_ClkInitTypeDef]]
	- [[RCC_ClkInitStruct]]

### [[PWR]]

```c
  /** Configure the main internal regulator output voltage
  */
  if (HAL_PWREx_ControlVoltageScaling(PWR_REGULATOR_VOLTAGE_SCALE1) != HAL_OK)
  {
    Error_Handler();
  }
```
- [[HAL_PWREx_ControlVoltageScaling]]
	- [[PWR_REGULATOR_VOLTAGE_SCALE1]]
		- [[HAL_OK]]
		- [[Error_Handler]]

### Osc

```c
  /** Initializes the RCC Oscillators according to the specified parameters
  * in the RCC_OscInitTypeDef structure.
  */
  RCC_OscInitStruct.OscillatorType = RCC_OSCILLATORTYPE_HSI48|RCC_OSCILLATORTYPE_MSI;
  RCC_OscInitStruct.HSI48State = RCC_HSI48_ON;
  RCC_OscInitStruct.MSIState = RCC_MSI_ON;
  RCC_OscInitStruct.MSICalibrationValue = 0;
  RCC_OscInitStruct.MSIClockRange = RCC_MSIRANGE_6;
  RCC_OscInitStruct.PLL.PLLState = RCC_PLL_ON;
  RCC_OscInitStruct.PLL.PLLSource = RCC_PLLSOURCE_MSI;
  RCC_OscInitStruct.PLL.PLLM = 1;
  RCC_OscInitStruct.PLL.PLLN = 40;
  RCC_OscInitStruct.PLL.PLLP = RCC_PLLP_DIV2;
  RCC_OscInitStruct.PLL.PLLQ = RCC_PLLQ_DIV2;
  RCC_OscInitStruct.PLL.PLLR = RCC_PLLR_DIV2;
  if (HAL_RCC_OscConfig(&RCC_OscInitStruct) != HAL_OK)
  {
    Error_Handler();
  }
```
  - [[RCC_OscInitTypeDef#OscillatorType]] = 
	  - [[RCC_OSCILLATORTYPE_HSI48]]|[[RCC_OSCILLATORTYPE_MSI]];
	  - [[RCC_OSCILLATORTYPE_HSI]] @ [[l496disco]]
  - [[RCC_OscInitStruct]].HSIState = [[RCC_HSI_ON]];
	  - RCC_OscInitStruct.HSICalibrationValue = [[RCC_HSICALIBRATION_DEFAULT]];
  - [[RCC_OscInitTypeDef#HSI48State]] = [[RCC_HSI48_ON]];
  - [[RCC_OscInitTypeDef#MSIState]] = [[RCC_MSI_ON]];
  - [[RCC_OscInitTypeDef#MSICalibrationValue]] = 0;
  - [[RCC_OscInitTypeDef#MSIClockRange]] = [[RCC_MSIRANGE_6]];
  - [[RCC_OscInitTypeDef#PLL]]
	  - [[RCC_OscInitTypeDef#PLLState]] = [[RCC_PLL_ON]];
	  - [[RCC_OscInitTypeDef#PLLSource]] = [[RCC_PLLSOURCE_MSI]];
	  - [[RCC_OscInitTypeDef#PLLM]] = 1;
	  - [[RCC_OscInitTypeDef#PLLN]] = 40;
	  - [[RCC_OscInitTypeDef#PLLP]] = [[RCC_PLLP_DIV2]];
	  - [[RCC_OscInitTypeDef#PLLQ]] = [[RCC_PLLQ_DIV2]];
	  - [[RCC_OscInitTypeDef#PLLR]] = [[RCC_PLLR_DIV2]];
- [[HAL_RCC_OscConfig]]
	- [[RCC_OscInitStruct]]

### bus clocks

```c
  /** Initializes the CPU, AHB and APB buses clocks
  */
  RCC_ClkInitStruct.ClockType = RCC_CLOCKTYPE_HCLK|RCC_CLOCKTYPE_SYSCLK
                              |RCC_CLOCKTYPE_PCLK1|RCC_CLOCKTYPE_PCLK2;
  RCC_ClkInitStruct.SYSCLKSource = RCC_SYSCLKSOURCE_PLLCLK;
  RCC_ClkInitStruct.AHBCLKDivider = RCC_SYSCLK_DIV1;
  RCC_ClkInitStruct.APB1CLKDivider = RCC_HCLK_DIV1;
  RCC_ClkInitStruct.APB2CLKDivider = RCC_HCLK_DIV1;

  if (HAL_RCC_ClockConfig(&RCC_ClkInitStruct, FLASH_LATENCY_4) != HAL_OK)
  {
    Error_Handler();
  }
}
```
- [[RCC_CLOCKTYPE_HCLK]]
- [[RCC_CLOCKTYPE_SYSCLK]]
- [[RCC_CLOCKTYPE_PCLK1]]
- [[RCC_CLOCKTYPE_PCLK2]]
- [[RCC_SYSCLKSOURCE_PLLCLK]]
- [[RCC_SYSCLK_DIV1]]
- [[RCC_HCLK_DIV1]]
- [[HAL_RCC_ClockConfig]]
	- [[RCC_ClkInitStruct]]
	- [[FLASH_LATENCY_4]]

## LL

```c
  LL_FLASH_SetLatency(LL_FLASH_LATENCY_0);
  while(LL_FLASH_GetLatency()!= LL_FLASH_LATENCY_0){}
```
- [[LL_FLASH_SetLatency]]
	- [[LL_FLASH_LATENCY_0]]
	- [[LL_FLASH_GetLatency]]

```c
  LL_PWR_SetRegulVoltageScaling(LL_PWR_REGU_VOLTAGE_SCALE1);
  while (LL_PWR_IsActiveFlag_VOS() != 0){}
```
- [[LL_PWR_SetRegulVoltageScaling]]
	- [[LL_PWR_REGU_VOLTAGE_SCALE1]]
	- [[LL_PWR_IsActiveFlag_VOS]]

```c
  LL_RCC_MSI_Enable();
   /* Wait till MSI is ready */
  while(LL_RCC_MSI_IsReady() != 1){}
```

- [[LL_RCC_MSI_Enable]]
- [[LL_RCC_MSI_IsReady]]

```c
  LL_RCC_MSI_EnableRangeSelection();
  LL_RCC_MSI_SetRange(LL_RCC_MSIRANGE_6);
  LL_RCC_MSI_SetCalibTrimming(0);
```
- [[LL_RCC_MSI_EnableRangeSelection]]
- [[LL_RCC_MSI_SetRange]]
	- [[LL_RCC_MSIRANGE_6]]
- [[LL_RCC_MSI_SetCalibTrimming]]

```c
  LL_RCC_SetSysClkSource(LL_RCC_SYS_CLKSOURCE_MSI);
   /* Wait till System clock is ready */
  while(LL_RCC_GetSysClkSource() != LL_RCC_SYS_CLKSOURCE_STATUS_MSI){}
```
- [[LL_RCC_SetSysClkSource]]
	- [[LL_RCC_SYS_CLKSOURCE_MSI]]
- [[LL_RCC_GetSysClkSource]]
	- [[LL_RCC_SYS_CLKSOURCE_STATUS_MSI]]



- [[LL_RCC_HSE_Enable]]
- [[LL_RCC_HSE_IsReady]]

- [[LL_PWR_EnableBkUpAccess]]

- [[LL_RCC_LSE_Enable]]
	- [[LL_RCC_LSE_IsReady]]

- [[LL_RCC_SetAHBPrescaler]]
	- [[LL_RCC_SYSCLK_DIV_1]]
- [[LL_RCC_SetAPB1Prescaler]]
	- [[LL_RCC_APB1_DIV_1]]
- [[LL_RCC_SetAPB2Prescaler]]
	- [[LL_RCC_APB2_DIV_1]]
- [[LL_RCC_SetSysClkSource]]
	- [[LL_RCC_SYS_CLKSOURCE_HSE]]
- [[LL_RCC_GetSysClkSource]]

- [[LL_Init1msTick]] 8000000
