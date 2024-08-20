#if defined(WIN32) || defined(_WIN32) || defined(__WIN32__) || defined(__NT__)
// Windows (32-bit and 64-bit
#ifdef _WIN64
// Windows (64-bit only)
#else
// Windows (32-bit only)
#endif

#elif __APPLE__
#include <TargetConditionals.h>
#if TARGET_IPHONE_SIMULATOR
// iOS, tvOS, or watchOS Simulator
#elif TARGET_OS_MACCATALYST
// Mac's Catalyst (ports iOS API into Mac, like UIKit).
#elif TARGET_OS_IPHONE
// iOS, tvOS, or watchOS device
#elif TARGET_OS_MAC
// Other kinds of Apple platforms
#else
#error "Unknown Apple Platform"
#endif

#elif __ANDROID__
// Below __linux__ check should be enough to handle Android,
// but something may be unique to Android.
#elif __linux__
// linux
#elif __unix__
// All unixes not captured above
// Unix
#elif defined(_POSIX_VERSION)
// POSIX
#else
#error "Unknown Compiler"
#endif
