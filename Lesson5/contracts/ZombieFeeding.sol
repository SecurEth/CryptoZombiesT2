pragma solidity ^0.4.24;

/// @title CryptoZombies Lesson 3
/// @author H4XF13LD MORRIS 💯💯😎💯💯 (documentation by Rex Hygate)
// @Github https://github.com/SecurEth/CryptoZombiesT1/Chapter2
// @SDD "./doc./System Description Document.md"
// @ARCH ./doc/Crpto...

import "./zombiefactory.sol";

contract KittyInterface {
    function getKitty(uint256 _id) external view returns (
        bool isGestating,
        bool isReady,
        uint256 cooldownIndex,
        uint256 nextActionAt,
        uint256 siringWithId,
        uint256 birthTime,
        uint256 matronId,
        uint256 sireId,
        uint256 generation,
        uint256 genes
    );
}

contract ZombieFeeding is ZombieFactory {

    KittyInterface kittyContract;

    // req ZFE1 Allow the kitty address to be set and updated when required
    // Check if there are kitties at that address
    function setKittyContractAddress(address _address) external onlyOwner {
        kittyContract = KittyInterface(_address);
    }
    // req ZFE2 Increase the ready time by the cooldown time, triggering a coo
    function _triggerCooldown(Zombie storage _zombie) internal {
        _zombie.readyTime = uint32(now + cooldownTime);
    }
    // req ZFE3 returns TRUE when zombie ready to feed or fight (cooldown is complete)
    function _isReady(Zombie storage _zombie) internal view returns (bool) {
        return (_zombie.readyTime <= now);
    }

    // req ZFE4 Mix the dna of the feeding zombie and the targetted kitty to a new dna
    // req ZFE5 Ensure only the owner can execute the function
    // req ZFE6 Only run this function if the zombie is ready (not in cooldown)
    // req ZFE7 If the species variable is "kitty" put a 99 at the end of the dna
    // req ZFE8 create a new zombie, called "Noname" with the resulting new dna
    // req ZFE9 Start a cooldown of the zombie
    function feedAndMultiply(uint _zombieId, uint _targetDna, string _species) internal {
        require(msg.sender == zombieToOwner[_zombieId], "Zombie not owned by you");
        require(_isReady(myZombie), "Zombie still in cooldown");
        Zombie storage myZombie = zombies[_zombieId];
        _targetDna = _targetDna % dnaModulus;
        uint newDna = (myZombie.dna + _targetDna) / 2;
        if (keccak256(abi.encodePacked(_species)) == keccak256(abi.encodePacked("kitty"))) {
            newDna = newDna - newDna % 100 + 99;
        }
        _createZombie("NoName", newDna);
        _triggerCooldown(myZombie);
    }

    // req ZFE10 Have one zombie feed on the specified kitty and create a new zombie of species kitty
    function feedOnKitty(uint _zombieId, uint _kittyId) public {
        uint kittyDna;
        // Add require address is non zero
        (,,,,,,,,,kittyDna) = kittyContract.getKitty(_kittyId);
        // require is address has no kitties
        feedAndMultiply(_zombieId, kittyDna, "kitty");
    }

}
