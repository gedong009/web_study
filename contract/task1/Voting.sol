// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// ✅ 创建一个名为Voting的合约，包含以下功能：
// 一个mapping来存储候选人的得票数
// 一个vote函数，允许用户投票给某个候选人
// 一个getVotes函数，返回某个候选人的得票数
// 一个resetVotes函数，重置所有候选人的得票数
contract Voting {
    mapping (string name => uint8 votes) people;

    function vote (string memory name, uint8 votes) public {
        require(votes > 0, "Votes must be greater than zero");
        people[name] += votes;
    }
    
    function getVotes(string memory name) public view returns (uint8) {
        return people[name];
    }

    function resetVotes(string memory name) public {
        people[name] = 0;
    }
}
