// SPDX-License-Identifier: GPL-3.0

// pragma is the directive through which
// we write the smart contract
pragma solidity 0.6.0;
 
// Creating a contract
contract wallet{
 
     // Specify the owner's address
     // which is publicly visible
     address payable public Owner;
 
      // Mapping is done from
     // address=>uint for transaction
      mapping(address => uint) Amount;
       
     // Constructor 'payable' is created,
     // which means it cost ether during the
     // deployment
      constructor() public payable{
       
     // msg.sender is the address of the person
     // who has currently deployed contract   
      Owner = msg.sender;
      
     // msg.value is the value of the ether we
     // are giving during the deploying of contract
      Amount[Owner] = msg.value;

     }
            
     // Modifier is created
      modifier onlyOwner(){
            
        // require is used whether the owner is the
        // person who has deployed the contract or not
         require(Owner == msg.sender);
         _;
        }
   
     // Defining a function to send money,
     // we have used modifier(onlyOwner)
     // it will check the required condition,
     // here condition is the only owner can
     // call this function
      function sendMoney(
       address payable receiver, uint amount)
       public payable onlyOwner {
           
         // receiver account balance should be > 0
           require( receiver.balance>0);
            
         // amount should not be negative ,
         // otherwise it throw error
           require(amount >0);
            
           Amount[Owner] -= amount;
           Amount[receiver] += amount;
      }
       
         // Defining a function to receive money    
         function ReceiveMoney() public payable{
            
           // Receiving money in owners
         // account directly
           Amount[Owner] += msg.value;
      }
       
         // Defining a function to return
         // the balance of the contract
         // account owned by the owner
         function CheckBalance_contractAccount()
           public view onlyOwner returns(uint){
            
           // return the balance of contract
         // account owned by owner
           return address(this).balance;
           }
  
         // Defining a function to check the
         // current balance of the owner account
         function CheckBalance()
           public view onlyOwner returns(uint){
              
                 // return the current balance
                 // of the owner's account
                 return Amount[Owner];
          }
}
