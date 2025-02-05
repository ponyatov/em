/// @defgroup cli cli

/// @defgroup object object
/// @ingroup cli
/// @{

/// @brief core Object model
class Object {
  public:
  private:
    uint32_t ref = 0;    ///< ref counter
    static Object* pool; ///< global object pool (linked list)
    static void gc();    ///< garbage collection
};

/// @}
