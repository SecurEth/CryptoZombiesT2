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
            zb.createRandomZombie("t", {from: accounts[1]}),
            "Name bad length"
        );
    });

    it("Test req ZF_4c: should abort with an error, text too long", async function() {
        await truffleAssert.reverts(
            zb.createRandomZombie("testing and testing", {from: accounts[1]}),
            "Name bad length"
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
                    d = d.toNumber(); 
                    console.log("Id: ", n, "Name: ", s, "dna: ", d); // Print id validates req ZF_6
                }
            }
        });
    });

    it("Test reqs ZF_7 and ZF_8", async function() {
        await zb.createRandomZombie("Zombie1", { from: accounts[1] })
        .then(function(result) {
            for (var i = 0; i < result.logs.length; i++) {
                var log = result.logs[i];
                if (log.event == "NewZombie") {
                    var n = log.args.zombieId;
                    n = n.toNumber();
                    var s = log.args.name;
                    var d = log.args.dna;
                    var ad = log.args.zombieToOwner;
                    var oc = log.args.ownerZombieCount;
                    oc = oc.toNumber()
                    d = d.toNumber(); // Print dna validates req ZF_1, ZF_2
                    console.log("Address:",  ad, "Count:", oc); // Print id validates req ZF_7, ZF_8
                }
            }
        });
    });

    it("Test req ZF_9 Fails at second zombie from same account", async function() {
        await zb.createRandomZombie("Zombie1", {from: accounts[1]});
        await truffleAssert.reverts(
            zb.createRandomZombie("Zombie2", {from: accounts[1]}), 
            "Only works when you have no Zombies"
        );
    });
 
});
