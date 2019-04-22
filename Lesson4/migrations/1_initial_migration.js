var Migrations = artifacts.require("./Migrations.sol");
var ZombieFactory = artifacts.require("./ZombieFactory.sol");
var ZombieFeeding = artifacts.require("./ZombieFeeding.sol");
var ZombieAttack = artifacts.require("./ZombieAttack.sol");
var ZombieHelper = artifacts.require("./ZombieHelper.sol");

module.exports = function(deployer) {
  deployer.deploy(Migrations);
  deployer.deploy(ZombieFactory);
  deployer.deploy(ZombieFeeding);
  deployer.deploy(ZombieAttack);
  deployer.deploy(ZombieHelper);
};