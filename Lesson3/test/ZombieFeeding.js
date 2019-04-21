const ZombieHelper = artifacts.require("./ZombieHelper");
const assert = require("chai").assert;
const truffleAssert = require('truffle-assertions');

contract('ZombieHelper', (accounts) => {
    let zb;

    beforeEach(async () => {
        zb = await ZombieHelper.new({from: accounts[0]});
/*        await zb.createKittie ({from: accounts[0]})
        .then(function(result) {
            for (var i = 0; i < result.logs.length; i++) {
                var log = result.logs[i];
                if (log.event == "KittieAddr") {
                    var ad = log.args.kittieToOwner;
//                    console.log("Kittie Address: ", ad);
                }
            }
        }); */
    });


    it("Test req ZFE_1 (true)", async function() {
        await zb.createRandomZombie("Zombie1", {from: accounts[0]});
        console.log("Start wait 5 sec");
        wait(5000);
        console.log("End wait");
        await zb.feedOnKitty(0, 21, { from: accounts[0] });
    });
  
    it("Test req ZFE_1 (false)", async function() {
        await zb.createRandomZombie("Zombie1", {from: accounts[0]});
        console.log("Start wait 5 sec");
        wait(5000);
        console.log("End wait");
        await truffleAssert.reverts(
            zb.feedOnKitty(0, 21, { from: accounts[1] }),
            "Zombie not owned by you"
        );
    }); 

    it("Feed on Kitty, Test ZFE_2, ZFE_3, ZFE_4, ZFE_5", async function() {
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
        console.log("Start wait 5 sec");
        wait(5000);
        console.log("End wait");
        await zb.feedOnKitty(0, 21, {from: accounts[0]})
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

/*  Not testing this requirement.  Without the kitty contract on the test blockchain, 
    it does not work  
    it("Change kitty address ZFE_6 and ZFE_7 true", async function() {
        var ad = 23;
        zb.setKittyContractAddress(ad, {from: accounts[0]});
    });

    it("Change kitty address ZFE_6 and ZFE_7 false", async function() {
        var ad = 0x06012c8cf97BEaD5deAe237070F9587f8E7A266d;
        await truffleAssert.reverts(
            zb.setKittyContractAddress(ad, { from: accounts[1] }),
            "Called by other than owner."
        );
    }); */
    it("Cooldown Timer True, Test ZFE_9 True, ZFE_8, ZFE_10", async function() {
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
        console.log("Start wait 5 sec");
        wait(5000);
        console.log("End wait");
        await zb.feedOnKitty(0, 21, {from: accounts[0]})
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

    it("Cooldown Timer True, Test ZFE_9 False, ZFE_11", async function() {
        await zb.createRandomZombie("Zombie1", {from: accounts[0]});
        console.log("Start SHORT 1 sec");
        wait(1000);
        console.log("End wait");
        await truffleAssert.reverts(
            zb.feedOnKitty(0, 21, { from: accounts[0] }),
            "Zombie must be ready"
        );
    });
});

function wait(ms){
    var start = new Date().getTime();
    var end = start;
    while(end < start + ms) {
        end = new Date().getTime();
    }
}