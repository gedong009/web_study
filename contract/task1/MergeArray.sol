// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MergeArray {
    // ✅  合并两个有序数组 (Merge Sorted Array)
    // 题目描述：将两个有序数组合并为一个有序数组
    function mergeSortedArrays(uint[] memory nums1, uint[] memory nums2) public pure returns (uint[] memory) {
        uint[] memory merged = new uint[](nums1.length + nums2.length);
        uint i = 0;
        uint j = 0;

        for (uint k = 0; k < merged.length; k++) {
            if (i < nums1.length && (j >= nums2.length || nums1[i] < nums2[j])) {
                merged[k] = nums1[i];
                i++;
            } else {
                merged[k] = nums2[j];
                j++;
            }
        }
        return merged;
    }
}
