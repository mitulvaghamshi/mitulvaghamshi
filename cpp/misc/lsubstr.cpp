// Largest sub-string without repeating characters
// https://leetcode.com/problems/longest-substring-without-repeating-characters

#include <iostream>
#include <map>
#include <string>

class Solution {
  public:
    int lengthOfLongestSubstring(std::string s) {
        int count = 0, lcount = 0;
        std::unordered_map<char, int> map;
        for (char c : s) {
            if (++map[c] > 1) {
                count = 0;
                map.clear();
                map[c] = 1;
            }
            if (count++ >= lcount)
                lcount = count;
        }
        return lcount;
    }
};

int main(void) {
    Solution s = Solution();
    std::cout << s.lengthOfLongestSubstring("abcabcbb") // 3
              << std::endl;
    std::cout << s.lengthOfLongestSubstring("bbbbb") // 1
              << std::endl;
    std::cout << s.lengthOfLongestSubstring("pwwkew") // 3
              << std::endl;
    std::cout << s.lengthOfLongestSubstring("aaba") // 2
              << std::endl;
    std::cout << s.lengthOfLongestSubstring("dvdf") // 3
              << std::endl;
    std::cout << s.lengthOfLongestSubstring(
                     "abcabcabbcaabbccccdabbabcdefpqrsabcbcaaavv") // 10
              << std::endl;
    return 0;
}
