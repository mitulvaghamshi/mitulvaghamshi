#include <iostream>
#include <string>
#include <unordered_map>
#include <vector>

using namespace std;

// Largest sub-string without repeating characters
// https://leetcode.com/problems/longest-substring-without-repeating-characters/
class Solution {
public:
  int check(string s) {
    int c = 0, lc = 0;
    unordered_map<char, int> m;
    for (char c : s) {
      if (++m[c] > 1) {
        c = 0;
        m.clear();
        m[c] = 1;
      }
      if (c++ >= lc)
        lc = c;
    }
    return lc;
  }
};

int main(void) {
  Solution s{};
  vector<string> data = {
      "abcabcbb",                                   // 3
      "bbbbb",                                      // 1
      "pwwkew",                                     // 3
      "aaba",                                       // 2
      "dvdf",                                       // 3
      "abcabcbb",                                   // 3
      "abcabcabbcaabbccccdabbabcdefpqrsabcbcaaavv", // 10
  };
  for (auto d : data)
    cout << s.check(d) << endl;
  return 0;
}
