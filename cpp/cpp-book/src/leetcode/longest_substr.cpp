// Largest sub-string without repeating character.
// Leetcode: https://leetcode.com/problems/longest-substring-without-repeating-characters/

#include <iostream>
#include <map>
#include <string>

/// @brief Uncomplete
class Solution
{
public:
  /// @brief
  /// @param s
  /// @return
  int lengthOfLongestSubstring(std::string s)
  {
    int count = 0, lcount = 0;
    std::unordered_map<char, int> map;
    for (char c : s)
    {
      if (++map[c] > 1)
      {
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

/// @brief
/// @param argc
/// @param argv
/// @return
int longest_substr_main(void)
{
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
  std::cout << s.lengthOfLongestSubstring("abcabcabbcaabbccccdab"
                                          "babcdefpqrsabcbcaaavv") // 10
            << std::endl;
  return 0;
}
