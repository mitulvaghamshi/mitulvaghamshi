typedef unsigned char u8;

inline u8 read(u8 word, u8 n) { return (word >> n) & 1; }
inline u8 write(u8 word, u8 n) { return word | (1 << n); }
inline u8 flip(u8 word, u8 n) { return word ^ (1 << n); }
inline u8 clear(u8 word, u8 n) { return word & !(1 << n); }
