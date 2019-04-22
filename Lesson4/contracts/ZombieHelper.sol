/// @title CryptoZombies Lesson 3
/// @author H4XF13LD MORRIS 💯💯😎💯💯 (documentation by Rex Hygate)
// @Github https://github.com/SecurEth/CryptoZombiesT1/Chapter1
// @SDD "./doc./System Description Document.md"
// @ARCH ./doc/Crpto...

pragma solidity >=0.4.0 <0.6.0;

import "./zombiefeeding.sol";

contract ZombieHelper is ZombieFeeding {

    uint levelUpFee = 0.001 ether;  // Initial Level up Fee

    modifier aboveLevel(uint _level, uint _zombieId) {
      require(zombies[_zombieId].level >= _level);
      _;
    }

// req ZH1 The owner can withdraw the balance of the contract
    function withdraw() external onlyOwner {
       msg.sender.transfer(address(this).balance);
    }

// req ZH2 The owner can change the level up fee
    function setLevelUpFee(uint _fee) external onlyOwner {
        levelUpFee = _fee;
    }


// req ZH3 Level up a zombie after the fee is paid
// req ZH4 If the amount sent is not exactly the fee, reject the transaction
    function levelUp(uint _zombieId) external payable {
        require(msg.value == levelUpFee, "Amount sent not level up fee");
        zombies[_zombieId].level++;
    }

// req ZH5 Changes the name of a zombie
// req ZH6 Name change can only be done by the zombie's owner
    function changeName(uint _zombieId, string calldata _newName) external aboveLevel(2, _zombieId) {
        require(msg.sender == zombieToOwner[_zombieId]);
        // Check length of name
        zombies[_zombieId].name = _newName;
    }
// ZH7 Changes the dna of a zombie if it is above level 20
// ZH8 Only the owner of a zombie can change its dna
    function changeDna(uint _zombieId, uint _newDna) external aboveLevel(20, _zombieId) {
        require(msg.sender == zombieToOwner[_zombieId]);
        zombies[_zombieId].dna = _newDna;
    }

// ZH9 Create and return an array of the number of zombies by owner for use in other function
    function getZombiesByOwner(address _owner) external view returns(uint[] memory) {
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
