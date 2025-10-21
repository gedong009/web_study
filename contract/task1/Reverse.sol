// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Reverse {

    // ✅ 反转字符串 (Reverse String)
    // 题目描述：反转一个字符串。输入 "abcde"，输出 "edcba"
    function reverse(string calldata str) public pure returns(string memory){
        bytes memory strBytes = bytes(str);
        uint256 len = strBytes.length;
        bytes memory reversed = new bytes(len);
        for(uint i=0;i<len;i++){
            reversed[i]=strBytes[len-i-1];
        }
        return string(reversed);
    }

}
