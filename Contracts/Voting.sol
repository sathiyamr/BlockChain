// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract Voting {

    struct Candidate {
        uint id;
        string name;
        uint voteCount;

    }

    mapping(uint => Candidate) public candidates; 

    uint public candidateCount;

    mapping(address => bool) private hasVoted;

    constructor(string[] memory _candidateNames) {
        for (uint i = 0; i < _candidateNames.length; i++){
            candidateCount++; // increment the ID by 1 because the array starts from zero
            candidates[candidateCount] = Candidate({
                id: candidateCount,
                name: _candidateNames[i],
                voteCount: 0
            });  
        }
        
    }   

    function Vote(uint _candidateId) public {
        
        require(_candidateId > 0 && _candidateId <= candidateCount, "Candidate ID is not valid"); // check if the candidate id exist in the mapping and greater than zero
        require(!hasVoted[msg.sender], "You already Voted");

        candidates[_candidateId].voteCount++;
        hasVoted[msg.sender] = true;

    }
}