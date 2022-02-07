// SPDX-License-Identifier: MIT
pragma solidity >=0.5.0 <0.9.0;

// Struct to store candidate information like there roll_no and name
struct candidate_info {
    uint256 roll_no;
    string name;
}

contract voting {
    // datatype to store different states of registeration
    enum registeration {
        open,
        closed
    }

    // variable status to store current state of regsitration process
    registeration public status = registeration.open;

    candidate_info[] public index;

    // function to collect information of nominee
    function addCandidate(uint256 _roll_no, string memory _name) public {
        
        // To ensure registration is open
        if (status == registeration.open) {

            //  store the data into local variable and add to global variable
            candidate_info memory candidate = candidate_info({
                roll_no: _roll_no, 
                name: _name
            });
            // append information
            index.push(candidate);
        }
    }

    // function to change the state
    function changeStatus() public {
        if (status == registeration.open) {
            status = registeration.closed;
        } else {
            status = registeration.open;
        }
    }
}
