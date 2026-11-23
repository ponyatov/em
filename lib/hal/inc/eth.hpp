/// @defgroup eth Ethernet
/// @ingroup hal
/// @{
#pragma once

#include <stdint.h>
#include <string.h>

namespace hal {
namespace eth {

struct MAC {
    uint8_t byte[6];

    /// @brief `==` operator for @ref MAC s
    constexpr bool operator==(const MAC& o) const {
        for (int i = 0; i < 6; ++i)
            if (byte[i] != o.byte[i]) return false;
        return true;
    }

    /// @brief `!=` operator for @ref MAC s
    constexpr bool operator!=(const MAC& o) const { return !(*this == o); }

} __attribute__((packed));

static_assert(sizeof(MAC) == 6, "MAC must be exactly 6 bytes");

static constexpr MAC broadcast{{0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF}};
static constexpr MAC zero{{0x00, 0x00, 0x00, 0x00, 0x00, 0x00}};

enum class EtherType : uint16_t {
    IPv4      = 0x0800,
    ARP       = 0x0806,
    VLAN      = 0x8100,  ///< 802.1Q
    IPv6      = 0x86DD,
    LLDP      = 0x88CC,
    PAUSE     = 0x8808,  ///< 802.3x flow control
    // ...
};

struct frame {
    MAC dst;
    MAC src;
    EtherType ethertype;
    const uint8_t* payload;
    size_t payload_length;
} __attribute__((packed));

namespace enc28j60 {}
namespace w5500 {}

}  // namespace eth
}  // namespace hal

/// @}
