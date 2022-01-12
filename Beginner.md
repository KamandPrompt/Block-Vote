## Blockchain - Getting Started

This is a short Hello World tutorial to help you get started with blockchain development. All code segments have been commented wherever possible, Go through the comment to nderstand the function of code.

1. Dependencies
   1. Node package manager
   2. Truffle - to write and test deploy smart contracts
        `npm install truffle or npm install -g truffle, if you want to install locally or globally`
   3. Ganache - local eth blockchain
   4. Metamask - browser extension for cyrpto transactions
   5. Lite-server - serve website files `npm install lite-server`

2. Get ganache running. You can run it from the UI or if you're using ganache-cli, you can get it running with `ganache-cli` command in the terminal.

3. Initialise project directories with `truffle unbox pet-shop`. The following directories will be created:
   1. contracts - where all smart contracts are to be written
   2. migrations - where all migrations are stored. Migrations can be seen as versions of blockchain. Whenever we deploy smart contracts to the blockchain, a migration is made.
   3. test - directory to write tests for smart contracts
   4. src - files for frontend application

   Run `npm init` before proceeding further.

4. <b>Writing Smart Contracts</b>
   This Hello World application will display "Hello World" on the screen by default. User can change the text displayed using the smart contract.

   In the contracts directory, create a new file `HelloWorld.sol`. Paste the below code segment.
   ```
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
   ```

5. <b> Migrations </b>
    Create file 2_helloworld_init.js in migrations directory. Paste the below code segment.
    ```
    const Migrations = artifacts.require("HelloWorld");

    module.exports = function(deployer) {
        deployer.deploy(Migrations);
    };
    ```
   
6. <b>Truffle Console</b>
   Truffle provides a console where we can interact with the blockchain using web3. Open truffle console in terminal by running `truffle console`
   1. Run `HelloWorld.deployed().then(function(instance) {app = instance})`. This assigns the deployed running instance of the blockchain to variable app, which we can use to access the functions or read data we defined earlier in the smart contract.
   2. Run `app.message()`. It will output the default value of the message.
   
7. <b>Client Side Interface </b>
   1. Setup
      pet-shop init created a directory src. We will modify it.
      Put the folowing code in `index.html`.
      ```
      <!DOCTYPE html>
      <html lang="en">

      <head>
          <meta charset="UTF-8">
          <meta http-equiv="X-UA-Compatible" content="IE=edge">
          <meta name="viewport" content="width=device-width, initial-scale=1.0">
          <title>Block Hello</title>
          <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
          <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
          <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
          <script src="https://cdnjs.cloudflare.com/ajax/libs/web3/1.7.0-rc.0/web3.min.js" integrity="sha512-/PTXSvaFzmO4So7Ghyq+DEZOz0sNLU4v1DP4gMOfY3kFu9L/IKoqSHZ6lNl3ZoZ7wT20io3vu/U4IchGcGIhfw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
          <script src="./abi.js"></script>
      </head>

      <body>
          <h2 class="text-primary text-center">Blockchain</h2>
          <h5 id="message-text"></h5>

      </body>

      </html>
      ```
      
      Put the following code in src/js/app.js
      ```
      App = {
        web3Provider: null,
        contracts: {},
        account: '0x0',

        init: function() {
            return App.initWeb3();
        },

        initWeb3: function() {
            if (typeof web3 !== 'undefined') {
                // If a web3 instance is already provided by Meta Mask.
                App.web3Provider = window.ethereum;
                web3 = new Web3(window.ethereum);
            } else {
                // Specify default instance if no web3 instance provided
                App.web3Provider = new Web3.providers.HttpProvider('http://localhost:8545');
                web3 = new Web3(App.web3Provider);
            }
            return App.initContract();
        },

        initContract: function() {
            $.getJSON("build/contracts/HelloWorld.json", function(HelloWorld) {
                // Instantiate a new truffle contract from the artifact
                App.contracts.HelloWorld = TruffleContract(HelloWorld);
                // Connect provider to interact with contract
                App.contracts.HelloWorld.setProvider(App.web3Provider);

                return App.render();
            });
        },

        render: function() {
            var blockchainMessage;
            var messageText = $("message-text");
            var helloworldInstance;

            // Load contract data
            App.contracts.HelloWorld.deployed().then(function(instance) {
                helloworldInstance = instance;
                return helloworldInstance.message();
            }).then(function(message) {
                messageText.innerHTML = message;

            }).catch(function(error) {
                console.log(error);
            });
        }
      };

      $(function() {
          $(window).load(function() {
              App.init();
          });
      });
      ```
   3. Run application using `npm run dev`.
   
8. This is how a smart contract is deployed and accessed in a web application.


## Task
1. Create a text field and submit button to change the text on the blockchain.
2. Modify App.js to handle the submit button and update the message on the blockchain.