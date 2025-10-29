// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
// import "@openzeppelin/contracts/token/ERC721/extensions/IERC721Metadata.sol";


contract MyERC721 is IERC721 {
    struct TokenInfo {
        address owner;
        address approved;
        string uri;
    }
    string public name;
    string public symbol;
    uint256 public nextTokenId;
    mapping(address userAddress => uint256 balance) public userBalances;    //所有者的NFT数量
    mapping(uint256 tokenId => TokenInfo token) public tokens;      //NFT的信息
    mapping (address userAddress => mapping(address operator => bool approved)) public userApprovalAllToOperator;
    mapping (address userAddress => uint[]) public userTokenIds;

    mapping(address => mapping(address => uint256 )) public userAllowances;
    constructor (string memory _name, string memory _symbol){
        name = _name;
        symbol = _symbol;
        nextTokenId = 0;
    }

    function balanceOf(address _owner) external view returns (uint256){
        return userBalances[_owner];
    }

    function ownerOf(uint256 tokenId) external view tokenExist(tokenId) returns (address owner){
        return tokens[tokenId].owner;
    }
    
    function mintNFT (address recipient ,string calldata tokenURI) external returns (bool){
        uint256 newTokenId = nextTokenId++;
        tokens[newTokenId] = TokenInfo(recipient, address(0), tokenURI);
        userBalances[recipient]++;
        return true;
    }

    modifier tokenExist(uint256 tokenId){
        require(tokens[tokenId].owner != address(0), 'tokenId not exist');
        _;
    }

    function approve(address to, uint256 tokenId) external tokenExist(tokenId){
        tokens[tokenId].approved = to;
        emit Approval(msg.sender, to, tokenId);
    }

    function getApproved(uint256 tokenId) external view tokenExist(tokenId) returns (address operator){
        return tokens[tokenId].approved;
    }

    function setApprovalForAll(address operator, bool approved) external{
        userApprovalAllToOperator[msg.sender][operator] = approved;
        emit ApprovalForAll(msg.sender, operator, approved);
    }

    function isApprovedForAll(address owner, address operator) external view returns (bool){
        return userApprovalAllToOperator[owner][operator];
    }

    function transferFrom(address from, address to, uint256 tokenId) public{
        require(to != address(0), "Invalid address");
        require(msg.sender == tokens[tokenId].owner || msg.sender == tokens[tokenId].approved || userApprovalAllToOperator[msg.sender][to], "Not approved");
        tokens[tokenId].owner = to;
        tokens[tokenId].approved = address(0);
        userBalances[from] -= 1;
        userBalances[to] += 1;
        emit Transfer(from, to, tokenId);
    }

    function safeTransferFrom(address from, address to, uint256 tokenId, bytes memory data) public{
        transferFrom(from, to, tokenId);
    }

    function safeTransferFrom(address from, address to, uint256 tokenId) external{
        safeTransferFrom(from, to, tokenId, "");
    }
    
    function supportsInterface(bytes4 interfaceId) external view returns (bool){
        return true;
    }
}