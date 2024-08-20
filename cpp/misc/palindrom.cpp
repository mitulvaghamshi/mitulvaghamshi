#include <cstdio>

int isPalindrome(int x) {
    if (x < 0) {
        return 0;
    }
    int nums[11];
    int len = 0;
    while (x > 0) {
        nums[len++] = x % 10;
        x /= 10;
    }
    for (int i = 0, j = len - 1; i < j; i++, j--) {
        if (nums[i] != nums[j]) {
            return 0;
        }
    }
    return 1;
}

int main(void) {
    int result1 = isPalindrome(2112112112);
    printf(result1 ? "Palindrom\n" : "Not Palindrom\n");

    return 0;
}
