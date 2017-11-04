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
    
    function add_item(bytes32 _name, uint _from, uint _to, bytes32 _weight, bytes32 _name_from, bytes32 _name_to) public returns(uint) {
        uint index = itemCount;
        items[index] = Item({
            name: _name,
            from: _from,
            to: _to,
            weight: _weight,
            name_from: _name_from,
            name_to: _name_to
        });
        item_paths[index].push(_from);
        item_paths_time[index].push(now);
        itemCount++;
        return index;
    }
    
    function get_item(uint _index) constant public returns (bytes32, uint, uint, bytes32, bytes32, bytes32){
        return (items[_index].name, items[_index].from, items[_index].to, items[_index].weight, items[_index].name_from, items[_index].name_to);
    }
    
    function transfer(uint _index, uint _from, uint _to) public returns (bool) {
        require(item_paths[_index][item_paths[_index].length - 1] == _from && items[_index].to != _from && msg.sender == stock_addresses[_from]);
        item_paths[_index].push(_to);
        return true;
    }
    
    function get_path(uint _index) constant public returns (uint[]) {
        return item_paths[_index];
    }
} 
