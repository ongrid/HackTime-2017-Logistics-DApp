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
    
    function add_stock(bytes32 _name, address _address) public returns(uint) {
        stock_names[stockCount] = _name;
        stock_addresses[stockCount] = _address;
        uint index = stockCount;
        stockCount++;
        return index;
    }
    
    function get_stock_address(uint _index) constant public returns (address) {
        return stock_addresses[_index];
    }
    
    function get_stock_name(uint _index) constant public returns (bytes32) {
        return stock_names[_index];
    }
} 
