/// @title CryptoZombies Lesson 4
/// @author H4XF13LD MORRIS 💯💯😎💯💯 (documentation by Rex Hygate)
// @Github https://github.com/SecurEth/CryptoZombiesT1/Chapter1
// @SDD "./doc./System Description Document.md"
// @ARCH ./doc/Crpto...

pragma solidity ^0.4.24;

import "./zombiehelper.sol";

contract ZombieBattle is ZombieHelper {
    uint randNonce = 0;
    uint attackVictoryProbability = 70;

    //req ZA_1 Generate a random number between 0 and the given Modulus
    function randMod(uint _modulus) internal returns(uint) {
        randNonce = randNonce.add(1);
        return uint(keccak256(now, msg.sender, randNonce)) % _modulus;
    }
    // req ZA_2 Perform a zombie on zombie attack
    // ZA_3 where your zombie wins, increment wincount
    // ZA_4 where your zombie wins, increment level
    // ZA_5 where your zombie wins, increment th attacked zombie loss count
    // ZA_6 where your zombie wins, create a new zombie with a mix of both zombie dna's
    // ZA_7 where your zombie loses, increment loss count
    // ZA_8 where your zombie loses, increment attacked zombie win count
    // ZA_9 where your zombie loses, trigger a cooldown
    function attack(uint _zombieId, uint _targetId) external ownerOf(_zombieId) {
        Zombie storage myZombie = zombies[_zombieId];
        Zombie storage enemyZombie = zombies[_targetId];       
        uint rand = randMod(100);
        if (rand <= attackVictoryProbability) {
            myZombie.winCount = myZombie.winCount.add(1);
            myZombie.level = myZombie.level.add(1);
            enemyZombie.lossCount = enemyZombie.lossCount.add(1);
            feedAndMultiply(_zombieId, enemyZombie.dna, "zombie");
        } else {
            myZombie.lossCount = myZombie.lossCount.add(1);
            enemyZombie.winCount = enemyZombie.winCount.add(1);
            _triggerCooldown(myZombie);
        }
    }
}
