// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract HotelRoom {

    address payable public owner;

    enum Statuses {Vacant, Occupied}

    Statuses currentStatus;

    event sendUpdate(address _sender,uint _amount);


    constructor() {        
        owner = payable(msg.sender);
        currentStatus = Statuses.Vacant;
    }

    modifier costs(uint _amount) {
        require(msg.value >= _amount, "Minimum 2 ether is required");
        _;
    }

    modifier onlyWhenVacant {
        require(currentStatus == Statuses.Vacant, "You can book only when you are vacant");
        _;
    }


    function book() payable public onlyWhenVacant costs(2 ether) {        
        currentStatus = Statuses.Occupied;
        owner.transfer(msg.value);
        emit sendUpdate(msg.sender,msg.value);
      } 
    
   
}