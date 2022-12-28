// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.5.0 <0.9.0;

contract EventContract{
    struct Event{
        address organiser;
        string name;
        uint date;
        uint price;
        uint ticketCount;
        uint ticketRemain;
    }

    mapping(uint => Event) public events;
    mapping(address => mapping(uint=>uint)) public tickets;
    // Initally set to 0
    uint public nextId;

    function createEvent(string memory name, uint date, uint price, uint ticketCount) external {
        require(date > block.timestamp, "The event can only be organised for future dates!");
        require(ticketCount>0, "You can organise event only if you create more than 0 tickets!");

        events[nextId] = Event(msg.sender, name, date,price,ticketCount,ticketCount);
        nextId++;
    }

    function buy_ticket(uint id, uint quantity)  external payable{
        // if an event is not there then the date will be zero, which we dont want 
        require(events[id].date != 0, "This event does not exist!");
        require(events[id].date > block.timestamp , "Event has already occured!");
        // we create a new variable of the struct type Event called _event
        Event storage _event = events[id];
        require(msg.value ==(_event.price*quantity), "Ether is not enough!");
        require(_event.ticketRemain >= quantity, "Not enough tickets!");
        _event.ticketRemain - quantity;
        tickets[msg.sender][id]+= quantity;
    }

    function transferTicket(uint id, uint quantity, address to) external {
        // if an event is not there then the date will be zero, which we dont want 
        require(events[id].date != 0, "This event does not exist!");
        require(events[id].date > block.timestamp , "Event has already occured!");
        require(tickets[msg.sender][id] >= quantity, "You do not have enough tickets!");
        tickets[msg.sender][id]-= quantity;
        tickets[to][id] += quantity;
    
    }

}
