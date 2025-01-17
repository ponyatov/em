#pragma once

/// @defgroup app app
/// @brief application-specific components
/// @{

#ifdef __cplusplus
extern "C" {
#endif

/// @brief runs after board startup
extern void setup();

/// @brief process command line arguments
/// @param[in] argc index ( 0 = program binary file name )
/// @param[in] argv values
extern void arg(int argc, char *argv);

/// @brief infinite application (event) loop
extern void loop();

#ifdef __cplusplus
}
#endif

/// @}
