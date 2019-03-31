const ZombieFactory = artifacts.require("./ZombieFactory");
const assert = require("chai").assert;
const truffleAssert = require('truffle-assertions');

contract('ZombieFactory', (accounts) => {
    let zb;

    beforeEach(async () => {
        zb = await ZombieFactory.new({from: accounts[1]});
    });

/*    afterEach(async () => {
    }); */
    
    it("Test reqs ZF_1, ZF_2, ZF_3, ZF_5, ZF_6", async function() {
        await zb.createRandomZombie("Zombie1", { from: accounts[0] })
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
              } else {
                console.log("Error");
              }
            }
        });
    });

    it("Test req ZF_4a: should complete successfully, text long enough", async () => {
        await zb.createRandomZombie("text3", {from: accounts[1]});
    });

    it("Test req ZF_4b: should abort with an error, text too short", async function() {
        await truffleAssert.reverts(
            zb.createRandomZombie("t", {from: accounts[1]})
        );
    });

    it("Test req ZF_4c: should abort with an error, text too long", async function() {
        await truffleAssert.reverts(
            zb.createRandomZombie("testing and testing", {from: accounts[1]})
        );
    });

    it("Test reqs ZF_6", async function() {
        await zb.createRandomZombie("Zombie1", { from: accounts[1] })
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
    
});
