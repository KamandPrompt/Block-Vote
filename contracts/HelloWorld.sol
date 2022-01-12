// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0; // License and Solidity version, same as the default in Migrations.sol

// contract contains the definition of the smart contract
contract HelloWorld {
    // data
    string public message; // public access so that we can directly access from outside of the contract

    // constructor
    constructor() public {
        message = "Hello World";
    }

    // functions
    function updateMessage(string memory _message) public {
        message = _message;
    }

}