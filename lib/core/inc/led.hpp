/// @defgroup led led
/// @ingroup io
/// @brief LED control

#include "object.hpp"
#include "pin.hpp"
#include "color.hpp"

class LED : public Object {
    Pin pin;
    Color color;

   public:
};
