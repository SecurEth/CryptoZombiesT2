pragma solidity >=0.4.0 <0.6.0;

/// @title CryptoZombies Chapter 2
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
        uint256 genes);
} 

contract ZombieFeeding is ZombieFactory {

    event Kitdna2(uint kitDna);

    // Fixed address of one particular kitty for now
    address ckAddress = 0x0ceF4411B29262300347072c24F2A53612F88633;
    KittyInterface kittyContract = KittyInterface(ckAddress);

    // req ZFE_1 Ensure only the owner can execute the function
    // req ZFE_2 Mix the dna of the feeding zombie and the targetted kitty to a new dna
    // req ZFE_3 If the species variable is "kitty" put a 99 at the end of the dna
    // req ZFE_4 create a new zombie, called "Noname" with the resulting new dna
    function feedAndMultiply(uint _zombieId, uint _targetDna, string memory _species) public {
        require(msg.sender == zombieToOwner[_zombieId], "Zombie not owned by you");
        Zombie storage myZombie = zombies[_zombieId];
        uint mod_targetDna = _targetDna % dnaModulus;
        uint newDna = (myZombie.dna + mod_targetDna) / 2;
        if (keccak256(abi.encodePacked(_species)) == keccak256(abi.encodePacked("kitty"))) {
            newDna = newDna - newDna % 100 + 99;
        }
        _createZombie("NoName", newDna);
    }

    // req ZFE_5 Have one zombie feed on the specified kitty and create a new zombie of species kitty
    function feedOnKitty(uint _zombieId, uint _kittyId) public {
        uint kittyDna = 5;
//        (,,,,,,,,,kittyDna) = kittyContract.getKitty(_kittyId);
//         Removed because it cannot be tested.  Replace before deployment
        kittyDna = 6231783;     // Delete before deployment
        uint dummy = _kittyId;  // Delete before deployment
        dummy++;                // Delete before deployment 
        feedAndMultiply(_zombieId, kittyDna, "kitty");
    }

}
