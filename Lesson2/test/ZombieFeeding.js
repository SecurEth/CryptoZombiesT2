const ZombieFactory = artifacts.require("./ZombieFeeding");
const assert = require("chai").assert;
const truffleAssert = require('truffle-assertions');

contract('ZombieFeeding', (accounts) => {
    let zb;

    beforeEach(async () => {
        zb = await ZombieFactory.new({from: accounts[0]});
        await zb.createKittie ({from: accounts[0]})
        .then(function(result) {
            for (var i = 0; i < result.logs.length; i++) {
                var log = result.logs[i];
                if (log.event == "KittieAddr") {
                    var ad = log.args.kittieToOwner;
//                    console.log("Kittie Address: ", ad);
                }
            }
        });
    });

    it("Test req ZFE_1 (true)", async function() {
        await zb.createRandomZombie("Zombie1", {from: accounts[0]});
        await zb.feedAndMultiply(0, 21, "kitty", { from: accounts[0] });
    });
  
    it("Test req ZFE_1 (false)", async function() {
        await truffleAssert.reverts(
            zb.feedAndMultiply(0, 21, "kitty", { from: accounts[1] }),
            "Zombie not owned by you"
        );
    }); 

    it("Feed on Kitty, Test ZFE_5, ZFE_2, ZFE_3, ZFE_4", async function() {
        await zb.createRandomZombie("Zombie1", {from: accounts[0]})
        .then(function(result) {
            for (var i = 0; i < result.logs.length; i++) {
                var log = result.logs[i];
                if (log.event == "NewZombie") {
                    var n = log.args.zombieId;
                    n = n.toNumber();
                    var s = log.args.name;
                    var d = log.args.dna;
                    d = d.toNumber(); 
                    console.log("Id: ", n, "Name: ", s, "dna: ", d);
                }
            }
        });
        await zb.feedOnKitty(0, 1, {from: accounts[0]})
        .then(function(result) {
            for (var i = 0; i < result.logs.length; i++) {
                var log = result.logs[i];
                if (log.event == "NewZombie") {
                    var n = log.args.zombieId;
                    n = n.toNumber();
                    var s = log.args.name;
                    var d = log.args.dna;
                    d = d.toNumber(); 
                    console.log("Id: ", n, "Name: ", s, "dna: ", d);
                }
            }
        });
    });

    
});
  