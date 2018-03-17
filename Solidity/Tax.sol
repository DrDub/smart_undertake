pragma solidity ^0.4.18;


contract Tax{
    
    mapping(address => uint256) balance;

    function transfer(address source, address target, address collect) public returns (bool) {
        require(target != address(0));
        require(collect != address(0));
        require(balance[source] > 0);
        
        balance[target] = balance[source] * 95/100;
        balance[collect] = balance[source]* 5/100;
        balance[source] =  balance[source] - balance[collect] - balance[target];
        
        if(balance[source] != 0){
            revert();
        }
        else{
            return true;
            
        }
    }
    
    function getbalance(address addr) public view returns (uint){
        return balance[addr];
    }
}
    

