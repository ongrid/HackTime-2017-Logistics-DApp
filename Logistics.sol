pragma solidity ^0.4.15;

contract PostService {
    uint itemCount;
    uint stockCount;
    address owner;
    
    function PostService() public {
        owner = msg.sender;
        itemCount = 0;
        stockCount = 0;
    }
    
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }
} 
