App = {
    web3Provider: null,
    contracts: {},

    init: async function() {
        return await App.initWeb3();
    },

    initWeb3: async function() {
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
        $.getJSON("HelloWorld.json", function(HelloWorld) {
            // Instantiate a new truffle contract from the artifact
            App.contracts.HelloWorld = TruffleContract(HelloWorld);
            // Connect provider to interact with contract
            App.contracts.HelloWorld.setProvider(App.web3Provider);

            return App.render();
        });
    },

    render: function() {
        var blockchainMessage;
        var messageText = document.getElementById("messagetext");
        var helloworldInstance;

        // Load contract data
        App.contracts.HelloWorld.deployed().then(function(instance) {
            helloworldInstance = instance;
            return helloworldInstance.message();
        }).then(function(message) {
            console.log(message);
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