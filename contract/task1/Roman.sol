// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Roman {
    function intToRoman(uint num) public pure returns(string memory) {
        require(num >= 1 && num <= 3999, "Invalid number");
        
        string[13] memory romanNum = ["M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"];
        uint[13] memory nums = [uint(1000), 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1];
        
        string memory roman;
        
        for (uint i = 0; i < romanNum.length; i++) {
            while (num >= nums[i]) {
                roman = string.concat(roman, romanNum[i]);
                num -= nums[i];
            }
        }
        
        return roman;
    }
}