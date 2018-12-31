# Architecture - Lesson 2

This architecture document is a bit artificial because the software was already written.  We are just documenting it.   Still we try to put the things that would be in each phase of the architecture

## R&D

Problem: How to create an effective random number on the blockchain
- Option 1: Use keccak256 of the name string.  Of course, this gives the same random number with the same string.
- Option 2: Use keccak256 of a number of elements
- Solution: Go with option 1

Problem: The game is too simple and boring
- Option 1: Add a battle interface
- Option 2 


## Flow

### Player
The Player create their first zombie
- Player enters a name  in a field (on the website)
- Player pushes a Create Zombie button
The Player feeds his Zombies (with CryptoKitties)
- The Player selects a zombie on his web interface page (on the website)
- The player selects a displayed kittie (from the CryptoKitties of a fixed address, on the website)
- The player selects feed, on the website
- The player gets a new zombie with kittie dna

## Sub-Features (To Do)

- Make Zombie tradable
- Figure a way for Zombies to battle each other and win or lose

## API (just the public variables and functioins)

### ZombieFactory.sol

    struct Zombie {
        string name;
        uint dna;
    }

    Zombie[] public zombies;

    mapping (uint => address) public zombieToOwner;
    mapping (address => uint) ownerZombieCount;


    function createRandomZombie(string _name) public {
    }

    function feedOnKitty(uint _zombieId, uint _kittyId) public {
    }

    function feedAndMultiply(uint _zombieId, uint _targetDna, string memory _species) public {
    }