/// @defgroup led led
/// @ingroup io
/// @brief LED control

#include "core.hpp"

class LED : public Object {
    Pin pin;
    Color color;
};
