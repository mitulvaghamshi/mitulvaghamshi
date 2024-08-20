uint f_randi(uint32 i) {
    i = (i < 13) ^ i;
    return ((i * (i * i * 15731 + 789221) + 1376312589) & 0x7fffffff);
}
