pragma solidity ^0.4.24;

/// @title CryptoZombies Lesson 3
/// @author H4XF13LD MORRIS 💯💯😎💯💯 (documentation by Rex Hygate)
// @Github https://github.com/SecurEth/CryptoZombiesT1/Chapter1
// @SDD "./doc./System Description Document.md"
// @ARCH ./doc/Crpto...

import "./ownable.sol";
import "./safemath.sol";


contract ZombieFactory is Ownable {
    
    using SafeMath for uint256;
    using SafeMath32 for uint32;
    using SafeMath16 for uint16;

    event NewZombie(uint zombieId, string name, uint dna);

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;
    uint cooldownTime = 1 days;
    uint minNameLength = 1;
    uint maxNameLength = 15;

    struct Zombie {
        string name;
        uint dna;
        uint32 level;
        uint32 readyTime;
        uint16 winCount;
        uint16 lossCount;
    }

    Zombie[] public zombies;

    mapping (uint => address) public zombieToOwner;
    mapping (address => uint) ownerZombieCount;

// req ZF1 Push the Zombie attributes in the zombies struct
// req ZF2 Emit the Zombie id, name and dna
// req ZF7 Save the owner of the zombie for future use
// req ZF8 Keep a count of the number of zombies each owner has
    function _createZombie(string _name, uint _dna) internal  {
        uint id = zombies.push(Zombie(_name, _dna, 1, uint32(now + cooldownTime), 0, 0)) - 1;
        zombieToOwner[id] = msg.sender;
        ownerZombieCount[msg.sender] = ownerZombieCount[msg.sender].add(1);
        emit NewZombie(id, _name, _dna);
    } 
// req ZF3 Generate a pseudo random number from a string which is returned as the dna
// req ZF4 Throw an error if string length is too short or long
// req ZF5 Create id which represents the index of the Zombie in the struct on blockchain
    function _generateRandomDna(string _str) private view returns (uint) {
        uint len = bytes(_str).length;
        require((len> minNameLength && len < maxNameLength), "Name bad length");  // New code added for tests
        uint rand = uint(keccak256(abi.encodePacked(_str)));
        return rand % dnaModulus;
    }

// req ZF6 Make Zombie in struct and emit id, name and dna
// req ZF9 Only run this function for the first zombie for each owner
    function createRandomZombie(string _name) public {
        require(ownerZombieCount[msg.sender] == 0);
        uint randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }

}

