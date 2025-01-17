#include "core.hpp"

/// @defgroup app app
/// @brief application-specific components
/// @{

/// @brief runs after board startup
extern void setup();

/// @brief process command line arguments
/// @param[in] argc index ( 0 = program binary file name )
/// @param[in] argv values
void arg(int argc, char *argv);

/// @brief infinite application (event) loop
extern void loop();

/// @}
