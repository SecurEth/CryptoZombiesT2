var ZombieFactorytestContract = artifacts.require("./ZombieFeeding");

contract("ZombieFeeding1", function(accounts) {
  
  it("Test reqs ZFE_1, ", async function() {
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
          console.log("Id: ", n, "Name: ", s, "dna: ", d); // Print id validates req ZF_1, ZF_2
        }
      }
    });
    let tx2 = await instance
    .feedOnKitty(0, 0, { from: accounts[1] })
    .then(function(result) {
/*      for (var i = 0; i < result.logs.length; i++) {
        var log = result.logs[i];
        if (log.event == "NewZombie") {
          var n = log.args.zombieId;
          n = n.toNumber();
          var s = log.args.name;
          var d = log.args.dna;
          d = d.toNumber(); // Print dna validates req ZF_1, ZF_2
          console.log("Id: ", n, "Name: ", s, "dna: ", d); // Print id validates req ZF_1, ZF_2 */
        assert.equal(n, 0, "Oops1");
/*        } else {
          console.log("Error");  
        } 
      } */
    }); 
  });
});

