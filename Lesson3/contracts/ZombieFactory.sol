pragma solidity >=0.4.0 <0.6.0;

/// @title CryptoZombies Chapter 3
/// @author H4XF13LD MORRIS 💯💯😎💯💯 (documentation by Rex Hygate)
// @Github https://github.com/SecurEth/CryptoZombiesT2/Lesson3
// @SDD "./doc./System Description Document.md"
// @ARCH ./doc/Crpto...
import "./ownable.sol";

contract ZombieFactory is Ownable {

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
    }

    Zombie[] public zombies;

    mapping (uint => address) public zombieToOwner;
    mapping (address => uint) ownerZombieCount;

// req ZF_6 Make Zombie in struct and emit id, name and dna
// req ZF_9 Only run this function for the first zombie for each owner
    function createRandomZombie(string memory _name) public {
        require(ownerZombieCount[msg.sender] == 0, "Only works when you have no Zombies");
        uint randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }

// req ZF_1 Push the Zombie attributes in the zombies struct
// req ZF_2 Emit the Zombie id, name and dna
// req ZF_7 Save the owner of the zombie for future use
// req ZF_8 Keep a count of the number of zombies each owner has
    function _createZombie(string memory _name, uint _dna) internal  {
        uint id = zombies.push(Zombie(_name, _dna, 1, uint32(now + cooldownTime))) - 1;
        zombieToOwner[id] = msg.sender;
        ownerZombieCount[msg.sender]++;
        emit NewZombie(id, _name, _dna);
    } 
// req ZF_3 Generate a pseudo random number from a string which is returned as the dna
// req ZF_4 Throw an error if string length is too short or long
// req ZF_5 Create id which represents the index of the Zombie in the struct on blockchain
    function _generateRandomDna(string memory _str) private view returns (uint) {
        uint len = bytes(_str).length;
        require((len > minNameLength && len < maxNameLength), "Name bad length");  // New code added for tests
        uint rand = uint(keccak256(abi.encodePacked(_str)));
        return rand % dnaModulus;
    }

}

