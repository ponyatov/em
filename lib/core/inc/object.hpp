#pragma once

#include "types.hpp"

/// @defgroup object object
/// @ingroup core
/// @brief root class for all objects
/// @{

/// @brief root class for all objects
class Object {
   private:
    /// @ingroup gc
    /// @{
    uint ref = 0;         ///< reference counter
    static Object* pool;  ///< global object pool
    Object* next;         ///< next object in linked list

    /// @}
   public:
    Object();   ///< construct any object
    ~Object();  ///< some clean up
};

/// @}
