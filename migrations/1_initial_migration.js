const Reputation = artifacts.require("Reputation");
const Marketplace = artifacts.require("Marketplace");

module.exports = function(deployer) {
  deployer.deploy(Reputation).then(
    function() {
      return deployer.deploy(Marketplace, Reputation.address);
    }
  );
};
