var ZombieFactorytestContract = artifacts.require("./ZombieFactory");

contract("ZombieFactory1", function(accounts) {
  
  it("Test reqs ZF_1, ZF_2, ZF_3, ZF_5, ZF_6", async function() {
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
          d = d.toNumber(); // Print dna validates req ZF_1, ZF_2
          console.log("Id: ", n, "Name: ", s, "dna: ", d); // Print id validates req ZF_1, ZF_2
          assert.equal(n, 0, "Zombie id not 0");
        } else {
          console.log("No Zombie event found");
        }
      }
    });
  });
});

contract("ZombieFactory2", function(accounts) {
  let myContract;
  let catchRevert = require("./exceptions.js").catchRevert;

  describe("Test req ZF_4", function() {
    before(async function() {
      myContract = await artifacts.require("ZombieFactory.sol").new();
    });

    it("Test ZF_4 Pass, text long enough", async function() {
      await myContract.createRandomZombie("text3", {from: accounts[1]});
    });

    it("Test ZF_4 FAIL, text too short", async function() {
      await catchRevert(myContract.createRandomZombie("t", {from: accounts[1]}));
    });
    it("Test ZF_4 FAIL, text too long", async function() {
      await catchRevert(myContract.createRandomZombie("testing and testing", {from: accounts[1]}));
    });
  });
});

contract("ZombieFactory3", function(accounts) {
  let myContract;
  let catchRevert = require("./exceptions.js").catchRevert;

  describe("Test req ZF_9", function() {
    before(async function() {
      myContract = await artifacts.require("ZombieFactory.sol").new();
    });

    it("Test req ZF_9 True, first zombie for account 1", async function() {
      await myContract.createRandomZombie("text3", {from: accounts[1]});
    });

    it("Test req ZF_9 False, not first zombie for this owner", async function() {
      await catchRevert(myContract.createRandomZombie("text4", {from: accounts[1]}));
    });
  });
});

contract("ZombieFactory4", function(accounts) {
  it("Test reqs ZF_6", async function() {
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
            d = d.toNumber(); // Print dna validates req ZF_1, ZF_2
            console.log("ZF_6 Id: ", n, "Name: ", s, "dna: ", d); // Print id validates req ZF_1, ZF_2
          }
        }
      });
      let tx2 = await instance
      .createRandomZombie("test3", { from: accounts[2] })
      .then(function(result) {
        for (var i = 0; i < result.logs.length; i++) {
          var log = result.logs[i];
          if (log.event == "NewZombie") {
            var n = log.args.zombieId;
            n = n.toNumber();
            var s = log.args.name;
            var d = log.args.dna;
            d = d.toNumber(); // Print dna validates req ZF_1, ZF_2
            console.log("ZF_6 Id: ", n, "Name: ", s, "dna: ", d);           
          }
        }
      });
  });
});

