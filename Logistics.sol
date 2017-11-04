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
    
    struct Item {
        bytes32 name;
        uint from;
        uint to;
        bytes32 weight;
        bytes32 name_from;
        bytes32 name_to;
    }
    
    mapping (uint => bytes32) public stock_names;
    mapping (uint => address) public stock_addresses;
    
    mapping (uint => Item) public items;
    mapping (uint => uint[]) public item_paths;
    mapping (uint => uint[]) public item_paths_time;
} 
