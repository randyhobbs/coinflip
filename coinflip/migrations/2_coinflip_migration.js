const coinFlip = artifacts.require("coinFlip");

module.exports = function(deployer, network, accounts) {

  deployer.deploy(coinFlip).then(function(instance){
    instance.fundContract({value: 100000000000000000000, from: accounts[0]});
  });
};
