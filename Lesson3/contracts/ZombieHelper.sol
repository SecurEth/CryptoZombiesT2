/// @title CryptoZombies Chapter 3
/// @author H4XF13LD MORRIS 💯💯😎💯💯 (documentation by Rex Hygate)
// @Github https://github.com/SecurEth/CryptoZombiesT1/Chapter1
// @SDD "./doc./System Description Document.md"
// @ARCH ./doc/Crpto...

pragma solidity ^0.4.24;

import "./zombiefeeding.sol";

contract ZombieHelper is ZombieFeeding {

    modifier aboveLevel(uint _level, uint _zombieId) {
      require(zombies[_zombieId].level >= _level);
      _;
    }
// req ZH_5 Changes the name of a zombie
// req ZH_6 Name change can only be done by the zombie's owner
    function changeName(uint _zombieId, string _newName) external aboveLevel(2, _zombieId) {
        require(msg.sender == zombieToOwner[_zombieId]);
        // Check length of name
        zombies[_zombieId].name = _newName;
    }
// ZH_7 Changes the dna of a zombie if it is above level 20
// ZH_8 Only the owner of a zombie can change its dna
    function changeDna(uint _zombieId, uint _newDna) external aboveLevel(20, _zombieId) {
        require(msg.sender == zombieToOwner[_zombieId]);
        zombies[_zombieId].dna = _newDna;
    }

// ZH_9 Create and return an array of the number of zombies by owner for use in other function
    function getZombiesByOwner(address _owner) external view returns(uint[]) {
        uint[] memory result = new uint[](ownerZombieCount[_owner]);
        uint counter = 0;
        for (uint i = 0; i < zombies.length; i++) {
            if (zombieToOwner[i] == _owner) {
                result[counter] = i;
                counter++;
            }
        }   
        return result;
    }
}
