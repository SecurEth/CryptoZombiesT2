pragma solidity >=0.4.0 <0.6.0;

/// @title CryptoZombies Lesson 3
/// @author H4XF13LD MORRIS 💯💯😎💯💯 (documentation by Rex Hygate)
// @Github https://github.com/SecurEth/CryptoZombiesT2/Lesson3
// @SDD "./doc./System Description Document.md"
// @ARCH ./doc/architecure.md

import "./zombiefeeding.sol";

contract ZombieHelper is ZombieFeeding {

    modifier aboveLevel(uint _level, uint _zombieId) {
        require(zombies[_zombieId].level >= _level, "Zombie level not high enough");
        _;
    }
    // req ZH_1 Changes the name of a zombie
    // req ZH_2 Name change can only be done by the zombie's owner
    function changeName(uint _zombieId, string calldata _newName) external aboveLevel(2, _zombieId) {
        require(msg.sender == zombieToOwner[_zombieId], "Zombie not owned by you");
        // Check length of name
        zombies[_zombieId].name = _newName;
    }
    
    // ZH_3 Changes the dna of a zombie if it is above level 20
    // ZH_4 Only the owner of a zombie can change its dna
    function changeDna(uint _zombieId, uint _newDna) external aboveLevel(20, _zombieId) {
        require(msg.sender == zombieToOwner[_zombieId], "Zombie not owned by you");
        zombies[_zombieId].dna = _newDna;
    }

    // ZH_5 Create and return an array of the number of zombies by owner for use in other function
    function getZombiesByOwner(address _owner) external view returns(uint[] memory ) {
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