var ZombieFactorytestContract = artifacts.require("./ZombieFactory");

contract("MyContractTest", function(accounts) {
  let myContract;
  let catchRevert = require("./exceptions.js").catchRevert;

  describe("Test req C1_4", function() {
      before(async function() {
          myContract = await artifacts.require("ZombieFactory.sol").new();
      });

      it("should complete successfully, text long enough", async function() {
          await myContract.createRandomZombie("text3", {from: accounts[1]});
      });

      it("should abort with an error, text too short", async function() {
          await catchRevert(myContract.createRandomZombie("t", {from: accounts[1]}));
      });
      it("should abort with an error, text too long", async function() {
        await catchRevert(myContract.createRandomZombie("testing and testing", {from: accounts[1]}));
    });
});
});

contract("ZombieFactory", function(accounts) {
  
  it("Test reqs C1_1, C1_2, C1_3, C1_5, C1_6", async function() {
    let instance = await ZombieFactorytestContract.deployed();
    let tx = await instance
      .createRandomZombie("test2", { from: accounts[0] })
      .then(function(result) {
        for (var i = 0; i < result.logs.length; i++) {
          var log = result.logs[i];
          if (log.event == "NewZombie") {
            var n = log.args.zombieId;
            n = n.toNumber();
            var s = log.args.name;
            var d = log.args.dna;
            d = d.toNumber(); // Print dna validates req C1_1, C1_2
            console.log("Id: ", n, "Name: ", s, "dna: ", d); // Print id validates req C1_1, C1_2
          } else {
            console.log("Error");
          }
        }
      });
    /*    assert.equal(tx.logs[0].event, "ActionAddRecord");
    assert.equal(tx.logs[0].args.projectId, 0); */
  });
  it("Test reqs C1_6", async function() {
    let instance = await ZombieFactorytestContract.deployed();
    let tx = await instance
      .createRandomZombie("test2", { from: accounts[1] })
      .then(function(result) {
        for (var i = 0; i < result.logs.length; i++) {
          var log = result.logs[i];
          if (log.event == "NewZombie") {
            var n = log.args.zombieId;
            n = n.toNumber();
            var s = log.args.name;
            var d = log.args.dna;
            d = d.toNumber(); // Print dna validates req C1_1, C1_2
            console.log("Id: ", n, "Name: ", s, "dna: ", d); // Print id validates req C1_1, C1_2
          }
        }
      });
    /*    assert.equal(tx.logs[0].event, "ActionAddRecord");
    assert.equal(tx.logs[0].args.projectId, 0); */
  });
});

