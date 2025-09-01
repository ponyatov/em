/**
 ******************************************************************************
 * @file    stm32f429i_discovery.c
 * @author  MCD Application Team
 * @brief   This file provides set of firmware functions to manage Leds and
 *          push-button available on STM32F429I-Discovery Kit from
 *STMicroelectronics.
 ******************************************************************************
 * @attention
 *
 * Copyright (c) 2017 STMicroelectronics.
 * All rights reserved.
 *
 * This software is licensed under terms that can be found in the LICENSE file
 * in the root directory of this software component.
 * If no LICENSE file comes with this software, it is provided AS-IS.
 *
 ******************************************************************************
 */

/* Includes ------------------------------------------------------------------*/
#include "stm32f429i_discovery.h"

/**
 * @brief STM32F429I DISCO BSP Driver version number V2.1.8
 */
#define __STM32F429I_DISCO_BSP_VERSION_MAIN \
    (0x02) /*!< [31:24] main version        \
            */
#define __STM32F429I_DISCO_BSP_VERSION_SUB1 \
    (0x01) /*!< [23:16] sub1 version        \
            */
#define __STM32F429I_DISCO_BSP_VERSION_SUB2 \
    (0x08) /*!< [15:8]  sub2 version        \
            */
#define __STM32F429I_DISCO_BSP_VERSION_RC \
    (0x00) /*!< [7:0]  release candidate */
#define __STM32F429I_DISCO_BSP_VERSION             \
    ((__STM32F429I_DISCO_BSP_VERSION_MAIN << 24) | \
     (__STM32F429I_DISCO_BSP_VERSION_SUB1 << 16) | \
     (__STM32F429I_DISCO_BSP_VERSION_SUB2 << 8) |  \
     (__STM32F429I_DISCO_BSP_VERSION_RC))
/**
 * @}
 */

/** @defgroup STM32F429I_DISCOVERY_LOW_LEVEL_Private_Variables STM32F429I
 * DISCOVERY LOW LEVEL Private Variables
 * @{
 */
GPIO_TypeDef *GPIO_PORT[LEDn] = {LED3_GPIO_PORT, LED4_GPIO_PORT};

const uint16_t GPIO_PIN[LEDn] = {LED3_PIN, LED4_PIN};

GPIO_TypeDef *BUTTON_PORT[BUTTONn] = {KEY_BUTTON_GPIO_PORT};
const uint16_t BUTTON_PIN[BUTTONn] = {KEY_BUTTON_PIN};
const uint8_t BUTTON_IRQn[BUTTONn] = {KEY_BUTTON_EXTI_IRQn};

/**
 * @brief  This method returns the STM32F429I DISCO BSP Driver revision
 * @retval version: 0xXYZR (8bits for each decimal, R for RC)
 */
uint32_t BSP_GetVersion(void) { return __STM32F429I_DISCO_BSP_VERSION; }

/**
 * @brief  Configures LED GPIO.
 * @param  Led: Specifies the Led to be configured.
 *   This parameter can be one of following parameters:
 *     @arg LED3
 *     @arg LED4
 */
void BSP_LED_Init(Led_TypeDef Led) {
    GPIO_InitTypeDef GPIO_InitStruct;

    /* Enable the GPIO_LED Clock */
    LEDx_GPIO_CLK_ENABLE(Led);

    /* Configure the GPIO_LED pin */
    GPIO_InitStruct.Pin = GPIO_PIN[Led];
    GPIO_InitStruct.Mode = GPIO_MODE_OUTPUT_PP;
    GPIO_InitStruct.Pull = GPIO_PULLUP;
    GPIO_InitStruct.Speed = GPIO_SPEED_FAST;

    HAL_GPIO_Init(GPIO_PORT[Led], &GPIO_InitStruct);

    HAL_GPIO_WritePin(GPIO_PORT[Led], GPIO_PIN[Led], GPIO_PIN_RESET);
}

/**
 * @brief  Turns selected LED On.
 * @param  Led: Specifies the Led to be set on.
 *   This parameter can be one of following parameters:
 *     @arg LED3
 *     @arg LED4
 */
void BSP_LED_On(Led_TypeDef Led) {
    HAL_GPIO_WritePin(GPIO_PORT[Led], GPIO_PIN[Led], GPIO_PIN_SET);
}

/**
 * @brief  Turns selected LED Off.
 * @param  Led: Specifies the Led to be set off.
 *   This parameter can be one of following parameters:
 *     @arg LED3
 *     @arg LED4
 */
void BSP_LED_Off(Led_TypeDef Led) {
    HAL_GPIO_WritePin(GPIO_PORT[Led], GPIO_PIN[Led], GPIO_PIN_RESET);
}

/**
 * @brief  Toggles the selected LED.
 * @param  Led: Specifies the Led to be toggled.
 *   This parameter can be one of following parameters:
 *     @arg LED3
 *     @arg LED4
 */
void BSP_LED_Toggle(Led_TypeDef Led) {
    HAL_GPIO_TogglePin(GPIO_PORT[Led], GPIO_PIN[Led]);
}

/**
 * @brief  Configures Button GPIO and EXTI Line.
 * @param  Button: Specifies the Button to be configured.
 *   This parameter should be: BUTTON_KEY
 * @param  ButtonMode: Specifies Button mode.
 *   This parameter can be one of following parameters:
 *     @arg BUTTON_MODE_GPIO: Button will be used as simple IO
 *     @arg BUTTON_MODE_EXTI: Button will be connected to EXTI line with
 * interrupt generation capability
 */
void BSP_PB_Init(Button_TypeDef Button, ButtonMode_TypeDef ButtonMode) {
    GPIO_InitTypeDef GPIO_InitStruct;

    /* Enable the BUTTON Clock */
    BUTTONx_GPIO_CLK_ENABLE(Button);

    if (ButtonMode == BUTTON_MODE_GPIO) {
        /* Configure Button pin as input */
        GPIO_InitStruct.Pin = BUTTON_PIN[Button];
        GPIO_InitStruct.Mode = GPIO_MODE_INPUT;
        GPIO_InitStruct.Pull = GPIO_PULLDOWN;
        GPIO_InitStruct.Speed = GPIO_SPEED_FAST;
        HAL_GPIO_Init(BUTTON_PORT[Button], &GPIO_InitStruct);
    }

    if (ButtonMode == BUTTON_MODE_EXTI) {
        /* Configure Button pin as input with External interrupt */
        GPIO_InitStruct.Pin = BUTTON_PIN[Button];
        GPIO_InitStruct.Pull = GPIO_NOPULL;
        GPIO_InitStruct.Mode = GPIO_MODE_IT_RISING;
        HAL_GPIO_Init(BUTTON_PORT[Button], &GPIO_InitStruct);

        /* Enable and set Button EXTI Interrupt to the lowest priority */
        HAL_NVIC_SetPriority((IRQn_Type)(BUTTON_IRQn[Button]), 0x0F, 0x00);
        HAL_NVIC_EnableIRQ((IRQn_Type)(BUTTON_IRQn[Button]));
    }
}

/**
 * @brief  Returns the selected Button state.
 * @param  Button: Specifies the Button to be checked.
 *   This parameter should be: BUTTON_KEY
 * @retval The Button GPIO pin value.
 */
uint32_t BSP_PB_GetState(Button_TypeDef Button) {
    return HAL_GPIO_ReadPin(BUTTON_PORT[Button], BUTTON_PIN[Button]);
}
