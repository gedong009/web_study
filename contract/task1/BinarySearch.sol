// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BinarySearch {
    function search (uint[] memory nums, uint key) public pure returns (uint) {
        uint left = 0;
        uint right = nums.length - 1;

        while (left <= right) {
            uint mid = (left + right) / 2;
            if (nums[mid] == key) {
                return mid;
            } else if (nums[mid] < key) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        
        return type(uint).max;
    }
}
