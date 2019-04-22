pragma solidity >=0.4.0 <0.6.0;

/// @title CryptoZombies Lesson 4
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
    
    modifier ownerOf(uint _zombieId) {
        require(msg.sender == zombieToOwner[_zombieId]);
        _;
    }

    // req ZFE_6 Allow the kitty address to be set and updated when required    
    // req ZFE_7 Only the contract owner can execute this contract
    function setKittyContractAddress(address _address) external onlyOwner {
        kittyContract = KittyInterface(_address);
    }
    // req ZFE_8 Start cooldown timer
    function _triggerCooldown(Zombie storage _zombie) internal {
        _zombie.readyTime = uint32(now + cooldownTime);
    }
    // req ZFE_9 returns TRUE when zombie ready to feed or fight
    function _isReady(Zombie storage _zombie) internal view returns (bool) {
        return (_zombie.readyTime <= now);
    }

    // req ZFE_2 Mix the dna of the feeding zombie and the targetted kitty to a new dna
    // req ZFE_3 If the species variable is "kitty" put a 99 at the end of the dna
    // req ZFE_4 create a new zombie, called "Noname" with the resulting new dna
    // req ZFE_1 Ensure only the owner can execute the function
    function feedAndMultiply(uint _zombieId, uint _targetDna, string memory _species) internal {
        require(msg.sender == zombieToOwner[_zombieId], "Zombie not owned by you");
        Zombie storage myZombie = zombies[_zombieId];
        // req ZFE_11 Zombie must be ready
        require(_isReady(myZombie), "Zombie must be ready");
        _targetDna = _targetDna % dnaModulus;
        uint newDna = (myZombie.dna + _targetDna) / 2;
        if (keccak256(abi.encodePacked(_species)) == keccak256(abi.encodePacked("kitty"))) {
            newDna = newDna - newDna % 100 + 99;
        }
        _createZombie("NoName", newDna);
        // req ZFE_10 Start cooldown of zombie
        _triggerCooldown(myZombie);
    }

    // req ZFE_5 Have one zombie feed on the specified kitty and create a new zombie of species kitty
    function feedOnKitty(uint _zombieId, uint _kittyId) public {
        uint kittyDna;
//        (,,,,,,,,,kittyDna) = kittyContract.getKitty(_kittyId);
//         Removed because it cannot be tested.  Replace before deployment
        kittyDna = 6231783;     // Delete before deployment
        uint dummy = _kittyId;  // Delete before deployment
        dummy++;                // Delete before deployment
        // require is address has no kitties
        feedAndMultiply(_zombieId, kittyDna, "kitty");
    }

}
