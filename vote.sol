// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Voting {

  /* 
  The key of the mapping is candidate name stored as type bytes32 and value is
  an unsigned integer to store the vote count
  */
  mapping (bytes32 => uint8) public votesReceived;
  
  bytes32[] public candidateList;

  function Vote_candi(bytes32[] memory candidateNames) public{
    candidateList = candidateNames;
  }

  // Total votes received by candidate
  function totalVotesFor(bytes32 candidate) public returns (uint8) {
    return votesReceived[candidate];
  }

  // Incrementing vote count for candidate
  function voteForCandidate(bytes32 candidate) public{
    votesReceived[candidate] += 1;
  }

  function validCandidate(bytes32 candidate) public returns (bool) {
    for(uint i = 0; i < candidateList.length; i++) {
      if (candidateList[i] == candidate) {
        return true;
      }
    }
    return false;
  }
  
}