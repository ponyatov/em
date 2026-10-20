/// @defgroup net net
/// @ingroup lib
/// @brief generic TCP/IP stack reimplementation over @ref hal
/// @{
#pragma once

/// @brief generic TCP/IP stack reimplementation over @ref hal
namespace net {

/// @brief generic network/io interface
template <class Impl>
class iface {
   public:
    ~iface() = default;
    bool open(const char* ifname) = 0;
    void close() = 0;
    bool send(uint8_t* data, size_t len) = 0;
    bool recv(uint8_t* data, size_t len, int timeout_ms) = 0;
    hal::eth::MAC mac() const = 0;
    Impl& self() { return *static_cast<Impl*>(this); }
    const Impl& self() const { return *static_cast<const Impl*>(this); }
};

}  // namespace net

/// @}
