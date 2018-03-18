pragma solidity ^0.4.18;



contract Tax{

    mapping(address => uint256) balances;
    event Taxed(uint sourcebalance, uint targetbalance, uint collectbalance);
    
     function GetBalance(address source, address target, address collect)public view returns (uint, uint, uint){
     
        return(source.balance, collect.balance, target.balance);
    }
    
    function transfer(address source, address target, address collect) public view returns (uint,uint, uint) {
        //require(target != address(0));
        //require(collect != address(0));
        //require(balance[source] > 0);
       
        balances[source] = source.balance;
        balances[target] = target.balance;
        balances[collect] = collect.balance;
        
        balances[target] += balances[source]*95/100;
        balances[collect] += balances[source]*5/100;
        balances[source] = 0;
    
    Taxed(balances[source],balances[target],balances[source]);
        
      return(balances[source],balances[target],balances[collect]);  
    }
    
   
}
    

