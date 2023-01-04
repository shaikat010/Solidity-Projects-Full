// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract HotelRoom { 

    //create an emun with 2 status so we can keep track of our hotel room
    enum Statuses { Vacant, Occupied }
    Statuses currentStatus; 

    // function to get the status of the room
    function getStatus() external view returns(string memory){
        if( currentStatus == Statuses.Vacant){
            return "Vacant";
        }

        else{
            return "Occupied";
        }
    }

    //create an event to owner, owner need information about one who rented and amount of money
    event Occupy ( address _occupant, uint _value);

    // owner variable, constructor, and current room status
    address public  owner;
    address public tenant; 

    constructor () { 
        owner = msg.sender; 
        currentStatus = Statuses.Vacant;
    }

    // modificator if only Vacant , we get payment; 
    modifier onlyWhileVacant { 
        require(currentStatus == Statuses.Vacant, " Currently Occupied");
        _;
    }

    // Room price Modificator 
    modifier price ( uint _amount ) { 
        require(msg.value >= _amount, "Not enough Money!");
    _;
    }

    // receive function , owner will get money, the Room status will be Occupied
    receive () external payable onlyWhileVacant price( 2 ether ) {
        currentStatus = Statuses.Occupied;
        payable(owner).transfer(msg.value);
        emit Occupy (msg.sender, msg.value);
        tenant = msg.sender;
        

    }
}
