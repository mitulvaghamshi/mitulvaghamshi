#include <iostream>

struct ListNode {
    int val;
    ListNode *next;

    ListNode() : val(0), next(nullptr) {}

    ListNode(int x) : val(x), next(nullptr) {}

    ListNode(int x, ListNode *next) : val(x), next(next) {}
};

class Solution {
  public:
    ListNode *addTwoNumbers(ListNode *l1, ListNode *l2) {
        int val = l1->val + l2->val;
        int carry = val > 9 ? val / 10 : 0;

        ListNode *ls = new ListNode(carry ? val % 10 : val);
        l1 = l1->next;
        l2 = l2->next;

        ListNode *lptr = ls;
        while (l1 && l2) {
            int val = l1->val + l2->val + carry;
            carry = val > 9 ? val / 10 : 0;
            lptr->next = new ListNode(carry ? val % 10 : val);
            lptr = lptr->next;
            l1 = l1->next;
            l2 = l2->next;
        }

        while (l1) {
            int val = l1->val + carry;
            carry = val > 9 ? val / 10 : 0;
            lptr->next = new ListNode(carry ? val % 10 : val);
            lptr = lptr->next;
            l1 = l1->next;
        }

        while (l2) {
            int val = l2->val + carry;
            carry = val > 9 ? val / 10 : 0;
            lptr->next = new ListNode(carry ? val % 10 : val);
            lptr = lptr->next;
            l2 = l2->next;
        }

        if (carry) {
            lptr->next = new ListNode(carry);
        }
        lptr = nullptr;

        return ls;

        //        ListNode *dummyHead = new ListNode(0);
        //        ListNode *curr = dummyHead;
        //        int carry = 0;
        //        while (l1 != NULL || l2 != NULL || carry != 0) {
        //            int x = l1 ? l1->val : 0;
        //            int y = l2 ? l2->val : 0;
        //            int sum = carry + x + y;
        //            carry = sum / 10;
        //            curr->next = new ListNode(sum % 10);
        //            curr = curr->next;
        //            l1 = l1 ? l1->next : nullptr;
        //            l2 = l2 ? l2->next : nullptr;
        //        }
        //        return dummyHead->next;
    }
};

int add_two_nums_main(void) {
    const int A1SIZE = 31;
    const int A2SIZE = 3;

    const int a1[A1SIZE] = {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1};
    const int a2[A2SIZE] = {5, 6, 4};

    ListNode *l1 = new ListNode(a1[0]);
    ListNode *l2 = new ListNode(a2[0]);

    size_t i = 1;
    ListNode *lptr = l1;
    while (i < A1SIZE) {
        lptr->next = new ListNode(a1[i++]);
        lptr = lptr->next;
    }

    i = 1;
    lptr = l2;
    while (i < A2SIZE) {
        lptr->next = new ListNode(a2[i++]);
        lptr = lptr->next;
    }

    Solution s = Solution();
    lptr = s.addTwoNumbers(l1, l2);
    while (lptr) {
        std::cout << lptr->val;
        lptr = lptr->next;
    }
    std::cout << std::endl;

    free(lptr);
    free(l1);
    free(l2);

    return 0;
}
