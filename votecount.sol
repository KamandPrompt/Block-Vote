// SPDX-License-Identifier: MIT
pragma solidity >=0.5.0 <0.9.0;

// Struct to store total vote count
struct CandidateVoteCount{
    uint count;
}

contract votecount{
    // datatype to store different states of registeration
    enum VotingStatus{open,closed}

    // variable status to store current state of regsitration process
    VotingStatus public Status=VotingStatus.open;

    // mapping index with total vote count
    mapping (uint => CandidateVoteCount) public  checkVoteCount;
    
    // function to input vote
    function vote(uint _id) public {
        if(Status==VotingStatus.open) {

            // To ensure registration is open
            checkVoteCount[_id].count +=1;
        }
    }
    
    
    // function to change the state
    function changeVotingStatus() public 
   {
      if (Status==VotingStatus.open){
          Status=VotingStatus.closed;
      } 
      else{
          Status=VotingStatus.open;
      }
   }
}