/// @defgroup uart uart
/// @ingroup io
/// @brief UART
/// @{

#include "io.hpp"

/// @brief standard baud rates
enum class Baud {
    _9600,
    _115200,
};

/// @brief hardware UART controller
class UART : public IO {
    Pin tx;
    Pin rx;
    Baud baud;

   public:
    UART(Pin tx, Pin rx, Baud baud = Baud::_115200);
};

/// @}
