pragma solidity ^0.4.18;

import "./SafeMath.sol";

contract SaleofGoods{
    using SafeMath for uint256;
    
    mapping(address => uint256) balance;

    function transfer(address buyer, address vendor, uint256 amount) public returns (bool) {
        require(vendor != address(0));
        require(amount <= balance[buyer]);
        require(balance[buyer] > 0);
        
        balance[buyer] = balance[buyer].sub(amount);
        balance[vendor] = balance[vendor].add(amount);
        
        return true;
    }
    
    function getbalance(address addr) public view returns (uint){
        return balance[addr];
    }
}
