var ZombieFeedingtestContract = artifacts.require("./ZombieFeeding");

contract("ZombieFeeding 1", function(accounts) {
  let myContract;
  let catchRevert = require("./exceptions.js").catchRevert;

  describe("Test req ZFE_1", function() {
    before(async function() {
      myContract = await artifacts.require("ZombieFeeding.sol").new();
    });

    it("First create a random zombie", async function() {
      await myContract.createRandomZombie("text3", {from: accounts[0]})
      .then(function(result) {
        for (var i = 0; i < result.logs.length; i++) {
          var log = result.logs[i];
          if (log.event == "NewZombie") {
            var n = log.args.zombieId;
            n = n.toNumber();
            var s = log.args.name;
            var d = log.args.dna;
            d = d.toNumber(); // Print dna validates req ZF_1, ZF_2
            console.log("Id: ", n, "Name: ", s, "dna: ", d); // Print id validates req ZF_1, ZF_2
          }
        }
      });
    });

    it("Test req ZFE_1 (true)", async function() {
      await myContract.feedOnKitty(0, 21, { from: accounts[0] });
    });

    it("Test req ZFE_1 (false)", async function() {
      await catchRevert(myContract.feedOnKitty(0, 21, { from: accounts[1] }));
    }); 
  });
});

contract("ZombieFeeding 2", function(accounts) {
  
  it("Make Initial Zombies, Test ZFE_2, ZFE_3, ZFE_4", async function() {
    let instance = await ZombieFeedingtestContract.deployed();
    let tx0 = await instance
    .createRandomZombie("TZombie0", { from: accounts[0] });
    let tx1 = await instance
    .createRandomZombie("TZombie1", { from: accounts[1] })
    .then(function(result) {
      for (var i = 0; i < result.logs.length; i++) {
        var log = result.logs[i];
        if (log.event == "NewZombie") {
          var n = log.args.zombieId;
          n = n.toNumber();
          var s = log.args.name;
          var d = log.args.dna;
          d = d.toNumber(); 
          console.log("Id of 2nd Zombie: ", n, "Name: ", s, "dna: ", d); 
        }
      }
    });
    let tx2 = await instance
    .feedOnKitty(0, 21, { from: accounts[0] })
    .then(function(result) {
      for (var i = 0; i < result.logs.length; i++) {
        var log = result.logs[i];
        if (log.event == "NewZombie") {
          var n = log.args.zombieId;
          n = n.toNumber();
          var s = log.args.name;
          var d = log.args.dna;
          d = d.toNumber(); 
          var e = d % 100;
          console.log("Test ZFE_2, ZFE_3 (true), ZFE_4 Id of new Zombie: ", n, "Name: ", s, "dna: ", d); // Print id validates req ZF_1, ZF_2
          assert.equal(e, 99, "Should be kitty dna");
          assert.equal(s, "NoName", "New Zombie name must be NoName");
        }
      }
    });
  });
});

