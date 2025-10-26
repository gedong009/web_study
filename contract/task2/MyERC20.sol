// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract SimpleERC20 is IERC20 {
    string public name;
    string public symbol;
    address public immutable ownerAddress;
    uint256 public immutable decimals;
    uint256 _totalSupply;
    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256 )) public userAllowances;

    constructor (string memory _name, string memory _symbol){
        name = _name;
        symbol = _symbol;
        decimals = 18;
        _totalSupply = 10000000 * 10 ** decimals;
        ownerAddress = msg.sender;
        balanceOf[msg.sender] = _totalSupply;
    }

    function mint (uint256 value) external returns (bool) {
        require(msg.sender == ownerAddress,"must owner");
        balanceOf[msg.sender] += value;
        return true;
    }

    function totalSupply() external view returns (uint256){
        return _totalSupply;
    }

    // function balanceOf(address account) external view returns (uint256){
    //     return balanceOf[account];
    // }
    // event Transfer(address indexed from, address indexed to, uint256 value);
    function transfer(address to, uint256 value) external returns (bool){
        balanceOf[msg.sender] -= value;
        balanceOf[to] += value;
        emit Transfer(address(0), to, value);
        return true;
    }

    function transferFrom(address from, address to, uint256 value) external returns (bool){
        require(balanceOf[from] >= value);
        require(userAllowances[from][msg.sender] >= value);
        balanceOf[from] -= value;
        balanceOf[to] += value;
        emit Transfer(from, to, value);
        return true;
    }
    // event Approval(address indexed owner, address indexed spender, uint256 value);  
    function approve(address spender, uint256 value) external returns (bool){
        userAllowances[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
        return true;
    }

    function allowance(address owner, address spender) external view returns (uint256){
        return userAllowances[owner][spender];
    }

}